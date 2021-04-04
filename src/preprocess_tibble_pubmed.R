library("tidyverse")

con <- DBI::dbConnect(RSQLite::SQLite(), dbname = "sqlite/pubmed.sqlite")
db <- dplyr::tbl(con, "pubmed")
pubmed <- tibble::as_tibble(db)

# Save
save(pubmed, file="tibble/pubmed_tbl.RData")