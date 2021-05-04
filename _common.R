set.seed(1014)

knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  # cache = TRUE,
  out.width = "70%",
  fig.align = 'center',
  fig.width = 6,
  fig.asp = 0.618,  # 1 / phi
  fig.show = "hold"
)

options(dplyr.print_min = 6, dplyr.print_max = 6)

# Activate crayon output
options(
  crayon.enabled = TRUE,
  pillar.bold = TRUE,
  stringr.html = FALSE
)


status <- function(type) {
  status <- switch(type,
    restructuring = "undergoing heavy restructuring and may be confusing or incomplete",
    drafting = "currently a dumping ground for ideas, and we don't recommend reading it",
    stop("Invalid `type`", call. = FALSE)
  )

  cat(paste0(
    "::: {.rmdnote}\n",
    "You are reading the work-in-progress second edition of R for Data Science. ",
    "This chapter is currently ", status, ". ",
    "You can find the polished first edition at <https://r4ds.had.co.nz>.\n",
    ":::\n"
  ))
}
