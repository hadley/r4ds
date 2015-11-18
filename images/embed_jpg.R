is_latex <- function() {
  identical(knitr::opts_knit$get('rmarkdown.pandoc.to'), "latex")
}

embed_jpg <- function(path, dpi) {
  dim <- jpg_dim(path)

  if (is_latex()) {
    width <- round(dim[2] / dpi, 2)

    knitr::asis_output(paste0(
      "\\includegraphics[",
      "width=", width, "in",
      "]{", path, "}"
    ))
  } else {
    knitr::asis_output(paste0(
      "<img src='", path, "'",
      " width='", round(dim[2] / (dpi / 96)), "'",
      " height='", round(dim[1] / (dpi / 96)), "'",
      " />"
    ))
  }
}

jpg_dim <- function(path) {
  dim(jpeg::readJPEG(path, native = TRUE))
}
