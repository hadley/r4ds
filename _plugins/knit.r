#!/usr/bin/Rscript
library(rmarkdown)
library(bookdown)
library(methods)

args <- commandArgs(trailingOnly = TRUE)
path <- temp.Rmd

if (!file.exists(path)) {
  stop("Can't find path ", path, call. = FALSE)
}

if (file.access(path, 4) != 0) {
  stop("Can't read path ", path, call. = FALSE)
}

html_path <- render(path, html_chapter(raw = TRUE, toc = "toc.rds"),
  quiet = TRUE)

read_file <- function(path) {
  size <- file.info(path)$size
  readChar(path, size, useBytes = TRUE)
}
cat(read_file(html_path))
