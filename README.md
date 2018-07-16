# R for Data Science

Este es el repositorio (y branch) para la traducción.

Instrucciones para colaborar:
1. Clona el repositorio a tu cuenta (e.g. `git clone git@github.com:cienciadedatos/r4ds.git`)
2. Crea un branch propio (e.g. traduccion-andrea, puedes hacer `git checkout -b traduccion-andrea`)
3. Cuando quieras subir tus cambios haz push a tu cuenta y luego haz un *Pull Request* indicando el branch `traducción` del repositorio `cienciadedatos/r4ds`.
4. Los admins se van a encargar de hacer los merge y que todo funcione.

This is code and text behind the [R for Data Science](http://r4ds.had.co.nz)
book. 

The R packages used in this book can be installed via

```{r}
devtools::install_github("hadley/r4ds")
```
The site is built using [bookdown package](https://github.com/rstudio/bookdown).
To create the site, you also need:

* [pandoc](http://johnmacfarlane.net/pandoc/)
