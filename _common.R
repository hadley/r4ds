set.seed(1014)

knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  cache = TRUE,
  out.width = "70%",
  fig.align = 'center',
  fig.width = 6,
  fig.asp = 0.618,  # 1 / phi
  fig.show = "hold"
)

options(dplyr.print_min = 6, dplyr.print_max = 6)

# Supress crayon output
options(crayon.enabled = FALSE)

second_ed <- function(name = NULL, url = NULL) {
  cat(paste0(
    "\n",
    "<div class='rmdnote'><p>\n",
    "You’re reading the first edition of R4DS; ",
    if (!is.null(name)) paste0(
      "for the latest on this topic see the <a href='", url, "'><strong>", name, " chapter",
      "</strong></a> in the second edition."
    ) else paste0(
      "this chapter doesn't have a direct equivalent in the second edition ",
      "see <a href='https://r4ds.hadley.nz/preface-2e.html'> for more details</a>"
    ),
    "</p></div>\n"
  ))
}
