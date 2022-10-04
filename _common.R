set.seed(1014)

knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  # cache = TRUE,
  fig.retina = 2,
  fig.width = 6,
  fig.asp = 2/3,
  fig.show = "hold"
)

options(
  dplyr.print_min = 6,
  dplyr.print_max = 6,
  stringr.view_n = 10
)

# Activate crayon output
options(
  #crayon.enabled = TRUE,
  pillar.bold = TRUE,
)

ggplot2::theme_set(ggplot2::theme_gray(12))

status <- function(type) {
  status <- switch(type,
    polishing = "should be readable but is currently undergoing final polishing",
    restructuring = "is undergoing heavy restructuring and may be confusing or incomplete",
    drafting = "is currently a dumping ground for ideas, and we don't recommend reading it",
    complete = "is largely complete and just needs final proof reading",
    stop("Invalid `type`", call. = FALSE)
  )

  cat(paste0(
    "::: status\n",
    "You are reading the work-in-progress second edition of R for Data Science. ",
    "This chapter ", status, ". ",
    "You can find the complete first edition at <https://r4ds.had.co.nz>.\n",
    ":::\n"
  ))
}
