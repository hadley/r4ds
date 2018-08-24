library(tidyverse)
contribs_all_json <- gh::gh("/repos/:owner/:repo/contributors",
  owner = "hadley",
  repo = "r4ds",
  .limit = Inf
)
contribs_all <- tibble(
  login = contribs_all_json %>% map_chr("login"),
  n = contribs_all_json %>% map_int("contributions")
)

contribs_old <- read_csv("contributors.csv", col_types = list())
contribs_new <- contribs_all %>% anti_join(contribs_old)

# Get info for new contributors
needed_json <- map(
  contribs_new$login,
  ~ gh::gh("/users/:username", username = .x)
)
info_new <- tibble(
  login = map_chr(needed_json, "login", .default = NA),
  name = map_chr(needed_json, "name", .default = NA),
  blog = map_chr(needed_json, "blog", .default = NA)
)
info_old <- contribs_old %>% select(login, name, blog)
info_all <- bind_rows(info_old, info_new)

contribs_all <- contribs_all %>%
  left_join(info_all) %>%
  arrange(login)
write_csv(contribs_all, "contributors.csv")
