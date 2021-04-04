library("tidyverse")

con <- DBI::dbConnect(RSQLite::SQLite(), dbname = "sqlite/pmc.sqlite")
db <- dplyr::tbl(con, "pmc")
pmc <- tibble::as_tibble(db)

# Save
save(pmc, file="tibble/pmc_tbl.RData")