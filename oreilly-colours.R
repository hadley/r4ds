library(farver)
library(dplyr, warn.conflicts = FALSE)

oreilly <- tribble(
  ~name,
  ~r,
  ~g,
  ~b,
  "blue",
  0,
  113,
  188,
  "orange",
  247,
  147,
  30,
  "red",
  193,
  39,
  45,
  "green",
  0,
  146,
  68,
  "yellow",
  255,
  222,
  0,
  "purple",
  153,
  0,
  204
)
oreilly$col <- encode_colour(oreilly[c("r", "g", "b")])

tint <- function(col, tint) {
  n <- length(tint)
  col_Lab <- decode_colour(col, to = "Lab")
  white_Lab <- decode_colour(white, to = "Lab")

  encode_colour(
    col_Lab[rep(1, n), ] * tint + white_Lab[rep(1, n), ] * (1 - tint),
    from = "Lab"
  )
}


tints <- seq(0.1, 1, length.out = 10)

oreilly |>
  group_by(name) |>
  summarize(
    tint = paste0("t", tints * 100),
    colour = tint(col, tints),
    .groups = "drop"
  ) |>
  tidyr::pivot_wider(names_from = tint, values_from = colour)

scales::show_col(tint(oreilly$col[5], tints))
