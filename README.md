# R for Data Science

[![Build Status](https://travis-ci.org/pachamaltese/r4ds.svg?branch=traduccion)](https://travis-ci.org/pachamaltese/r4ds)

Este es el repositorio (y branch) para la traducción de [R for Data Science](http://r4ds.had.co.nz).

Instrucciones para colaborar:
1. Haz un fork en tu cuenta de Github.
2. Clona el repositorio a tu cuenta (e.g. `git clone git@github.com:miusuario/r4ds.git`)
3. Crea un branch propio (e.g. traduccion-andrea, puedes hacer `git checkout -b traduccion-miusuario`)
4. Cuando quieras subir tus cambios haz push a tu cuenta y luego haz un *Pull Request* indicando el branch `traducción` del repositorio `cienciadedatos/r4ds`.
5. Los admins se van a encargar de hacer los merge y que todo funcione.

Puedes generar el libro directamente desde el archivo `index.rmd`. Asegurate de tener los siguientes paquetes instalados:

```{r}
install.packages("bookdown")
devtools::install_github("hadley/r4ds")
devtools::install_github("cienciadedatos/datos")
```
Revisa el código de conducta en el siguiente enlace: https://github.com/cienciadedatos/descripcion-y-orientaciones/issues/1
