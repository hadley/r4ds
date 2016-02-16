# R packages

This is code and text behind the [R for data science](http://r4ds.had.co.nz)
book. 

The site is built using [bookdown]

```{r}
devtools::install_github("yihui/knitr")
devtools::install_github("rstudio/bookdown")
```

jekyll, with a custom plugin to render `.rmd` files with
knitr and pandoc. To create the site, you need:

* jekyll gem: `gem install jekyll`
* bookdown: `install_github("hadley/bookdown")`
* [pandoc](http://johnmacfarlane.net/pandoc/)
* [knitr](http://yihui.name/knitr/): `install.packages("knitr")`

The R packages used in this book can be installed via

```{r}
devtools::install_github("hadley/r4ds")
```
