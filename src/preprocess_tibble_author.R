library("tidyverse")

con <- DBI::dbConnect(RSQLite::SQLite(), dbname = "sqlite/author.sqlite")
db <- dplyr::tbl(con, "author")
author <- tibble::as_tibble(db)

# Save
save(author, file="tibble/author_tbl.RData")