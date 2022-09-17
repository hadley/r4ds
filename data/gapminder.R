

repurrrsive::gap_simple |>
  count(year)

by_year <- repurrrsive::gap_simple |>
  group_by(year)
paths <- by_year |>
  group_keys() |>
  mutate(path = str_glue("data/gapminder/{year}.xlsx")) |>
  pull()
paths

years <- by_year |>
  group_split() |>
  map(\(df) select(df, -year))

dir.create("data/gapminder")

walk2(years, paths, writexl::write_xlsx)
