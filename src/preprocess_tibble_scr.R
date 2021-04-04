library("tidyverse")

con <- DBI::dbConnect(RSQLite::SQLite(), dbname = "sqlite/scr.sqlite")
db <- dplyr::tbl(con, "scr")
scr <- tibble::as_tibble(db)

# Save
save(scr, file="tibble/scr_tbl.RData")