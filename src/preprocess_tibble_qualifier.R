library("tidyverse")

con <- DBI::dbConnect(RSQLite::SQLite(), dbname = "sqlite/qualifier.sqlite")
db <- dplyr::tbl(con, "qualifier")
qualifier <- tibble::as_tibble(db)

# Save
save(qualifier, file="tibble/qualifier_tbl.RData")