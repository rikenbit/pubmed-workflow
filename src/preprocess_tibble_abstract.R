library("tidyverse")

con <- DBI::dbConnect(RSQLite::SQLite(), dbname = "sqlite/abstract.sqlite")
db <- dplyr::tbl(con, "abstract")
abstract <- tibble::as_tibble(db)

# Save
save(abstract, file="tibble/abstract_tbl.RData")