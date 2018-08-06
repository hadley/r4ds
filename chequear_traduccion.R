# x <- "https://raw.githubusercontent.com/melvidoni/r4ds/traduccion_melina/factors.Rmd"
# x <- "https://raw.githubusercontent.com/melvidoni/r4ds/traduccion_melina/datetimes.Rmd"

chequear_traduccion <- function(x = "https://raw.githubusercontent.com/melvidoni/r4ds/traduccion_melina/factors.Rmd") {
  
  library(tidyverse)
  library(hunspell)
  library(tidytext)
  
  data <- obtener_data(x)
  
  chequear_knitr(x)
  
  data <- limpiar_data(data)
  
  data_palabras <- chequear_palabras(data)
  
  data_titulos <- chequear_titulos(data)
  
  list(
    data_palabras,
    data_titulos
  )
  
}

chequear_knitr <- function(x = "https://raw.githubusercontent.com/melvidoni/r4ds/traduccion_melina/factors.Rmd") {
  
  message("chequear_knitr...")
  
  archivo_temp <- tempfile()
  download.file(x, destfile = archivo_temp)
  knitr::knit(input = archivo_temp, quiet = TRUE, envir = new.env())
  
}

obtener_data <- function(x = "https://raw.githubusercontent.com/melvidoni/r4ds/traduccion_melina/factors.Rmd") {
  
  message("obtener_data...")
  
  message("\tleyendo líneas")
  lineas <- read_lines(x)
  
  message("\tconstruyendo data_frame")
  data <- data_frame(
    linea = 1:length(lineas),
    texto = lineas
  )
  
  data
  
}

obtener_stopwords <- function() {
  
  message("obtener_stopwords...")
  
  data_stopwords <- data_frame(
    palabra = read_lines("https://raw.githubusercontent.com/stopwords-iso/stopwords-es/master/stopwords-es.txt")
  )
  
  data_stopwords
  
}

obtener_diccionario <- function(){
  
  message("obtener_diccionario...")
  
  dir_temp <- tempdir()
  
  url1 <- "https://raw.githubusercontent.com/titoBouzout/Dictionaries/master/Spanish.aff"
  url2 <- "https://raw.githubusercontent.com/titoBouzout/Dictionaries/master/Spanish.dic"
  
  destfile1 <- file.path(dir_temp, basename(url1))
  destfile2 <- file.path(dir_temp, basename(url2))
  
  download.file(url = url1, destfile = destfile1)
  download.file(url = url2, destfile = destfile2)
  
  dict <- dictionary(destfile1 %>% str_remove("\\.aff"))
  
  dict
  
}

obtener_funciones <- function(){
  
  message("obtener_funciones...")
  
  paquetes <- tidyverse:::tidyverse_packages()
  
  data_funciones <- paquetes %>% 
    map(~ try(ls(paste0("package:", .x)))) %>% 
    unlist() %>% 
    c(paquetes, "tidyverse") %>% 
    data_frame(palabra = .) %>% 
    distinct(palabra) %>% 
    filter(!str_detect(palabra, "Error"))
  
  data_funciones
  
}

limpiar_data <- function(data) {
  
  message("limpiar data")
  
  message("\tremoviendo líneas vacías")
  data <- filter(data, !str_detect(texto, "^\\s*$"))
  
  message("\tremoviendo bloques de códigos")
  data <- data %>% 
    mutate(
      comienza_bloque = str_detect(texto, "^\\s*```\\{r"),
      termina_bloque = str_detect(texto, "^\\s*```\\s*$"),
      bloque = cumsum(comienza_bloque + termina_bloque) + 1
    ) %>% 
    filter(bloque%%2 != 0) %>% 
    filter(!termina_bloque) %>% 
    select(-comienza_bloque, -termina_bloque, -bloque)
  
}

chequear_palabras <- function(data) {
  
  message("chequear_palabras...")
  
  message("\tunnest_tokens")
  
  # data_palabras <- unnest_tokens(data, palabra, texto, token = "words")
  # espacios, coma espacio, punto y coma espacio , dos puntos espacio, rmd links, y/o
  separadores <- c(
    "\\s+",
    "\\,\\s+",
    ";\\s+",
    "\\:\\s+",
    "\\]\\(",
    "/"
    )
  separadores <- paste0(separadores, collapse = "|")
  
  data_palabras <- unnest_tokens(data, palabra, texto, token = stringr::str_split, pattern = separadores, to_lower = FALSE)
  
  data_palabras <- data_palabras %>% filter(!str_detect(palabra, "^#*$"))                                   
  data_palabras <- data_palabras %>% mutate(palabra2 = tolower(palabra))                                             
  
  caracteres_inicales_finales <- c(
    "^\\(",
    "\\)$",
    "^_",
    "_$",
    "^\\[",
    "\\]$",
    "\\.$",
    "^\\¿",
    "\\?$",
    "^¡",
    "!$",
    ":$",
    "^\"",
    "\"$"
    )
  caracteres_inicales_finales <- paste0(caracteres_inicales_finales, collapse = "|")
  
  data_palabras <- data_palabras %>% mutate(palabra2 = str_remove_all(palabra2, caracteres_inicales_finales))    
  data_palabras <- data_palabras %>% mutate(palabra2 = str_remove_all(palabra2, caracteres_inicales_finales))
  data_palabras <- data_palabras %>% mutate(palabra2 = str_remove_all(palabra2, caracteres_inicales_finales))
  
  message("\tremoviendo stopwords")
  data_palabras <- data_palabras %>% 
    anti_join(obtener_stopwords(), by = c("palabra2" = "palabra"))
  
  message("\tremoviendo funciones tidyverse")
  data_palabras <- data_palabras %>% 
    anti_join(obtener_funciones(), by = c("palabra2" = "palabra")) 
  
  message("\tremoviendo `codigo`, algunos elementos md, urls")
  data_palabras <- data_palabras %>% 
    filter(!str_detect(palabra2, "^`") & !str_detect(palabra2, "`$")) %>% 
    filter(!palabra2 %in% c("*", "=")) %>% 
    filter(!str_detect(palabra2, "^https?"))
  
  dict_esp <- obtener_diccionario()
  dict_eng <- dictionary(lang = "en_US")
  
  data_palabras <- data_palabras %>% 
    mutate(
      check_esp = hunspell_check(palabra2, dict = dict_esp),
      check_eng = hunspell_check(palabra2, dict = dict_eng)
    )
  
  # remuevo palabras que se detectan del español
  data_palabras <- data_palabras %>% 
    filter(!check_esp)
  
  # remuevo palabras que se detectan del inglés
  data_palabras <- data_palabras %>% 
    filter(!check_eng)
  
  data_palabras <- data_palabras %>% 
    select(-check_esp, -check_eng)
  
  data_palabras
  
}

chequear_titulos <- function(data) {
  
  message("chequear_titulos...")
  
  data_titulos1 <- data %>% 
    filter(str_detect(texto, "^#+")) %>% 
    mutate(
      clase = str_extract(texto, "^#+\\s+"),
      titulo = str_remove(texto, "^#+\\s+"),
      titulo_corregido = stringi::stri_trans_totitle(titulo, opts_brkiter = stringi::stri_opts_brkiter(type = "sentence"))
    ) %>% 
    filter(titulo != titulo_corregido) %>% 
    unite(texto_corregido, clase, titulo_corregido, sep = "") %>% 
    select(-titulo)
  
  data_titulos2 <- data %>% 
    filter(str_detect(texto, "^#+\\s+Ejercicio\\s*$")) %>% 
    mutate(texto_corregido = str_replace(texto, "Ejercicio", "Ejercicios"))
  
  
  data_titulos <- list(
    data_titulos1,
    data_titulos2
  ) %>% 
    reduce(bind_rows) %>% 
    arrange(linea)
  
  data_titulos
  
}

# chequear_traduccion(x)
