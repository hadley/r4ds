# R for Data Science

<!-- badges: start -->

[![Render and deploy Book to Netlify](https://github.com/hadley/r4ds/actions/workflows/build_book.yaml/badge.svg)](https://github.com/hadley/r4ds/actions/workflows/build_book.yaml)

<!-- badges: end -->

This repository contains the source of [R for Data Science](http://r4ds.hadley.nz) book.
The book is built using [Quarto](https://quarto.org/).

The R packages used in this book can be installed via

```{r}
devtools::install_github("hadley/r4ds")
```

## Images

### Omnigraffle drawings

-   Font: 12pt Guardian Sans Condensed / Ubuntu mono

-   Export as 300 dpi png.

-   Website font is 18 px = 13.5 pt, so scale dpi to match font sizes: 270 = 300 \* 12 / 13.5.
    (I also verified this empirically by screenshotting.)

    ``` r
    #| echo: FALSE
    #| out.width: NULL
    knitr::include_graphics("diagrams/transform.png", dpi = 270)
    ```

### Screenshots

-   Make sure you're using a light theme.
    For small interface elements (eg. toolbars), zoom in twice.

-   Screenshot with Cmd + Shift + 4.

-   Don't need to set dpi:

    ``` r
    #| echo: FALSE
    #| out.width: NULL
    knitr::include_graphics("screenshots/rstudio-wg.png")
    ```

### O'Reilly

To generate book for O'Reilly, build the book then:

```{r}
devtools::load_all("../minibook/"); process_book()

html <- list.files("oreilly", pattern = "[.]html$", full.names = TRUE)
file.copy(html, "../r-for-data-science-2e/", overwrite = TRUE)

pngs <- list.files("oreilly", pattern = "[.]png$", full.names = TRUE, recursive = TRUE)
dest <- gsub("oreilly", "../r-for-data-science-2e/", pngs)
fs::dir_create(unique(dirname(dest)))
file.copy(pngs, dest, overwrite = TRUE)
```

## Code of Conduct

Please note that r4ds uses a [Contributor Code of Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this book, you agree to abide by its terms.
