library(stringr)
library(purrr)

chapters <- dir("_bookdown_files", full.names = TRUE, pattern = "_files$")

figures <- dir(chapters, full.names = TRUE, pattern = "-latex")

name <- figures %>%
  dirname() %>%
  basename() %>%
  str_replace("_files", "")

out_path <- file.path("figures", name)

dir.create("figures/")
out_path %>% walk(dir.create)

map2(figures, out_path, ~ file.copy(dir(.x, full.names = TRUE), .y))
