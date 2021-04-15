library("tidyverse")
library("data.table")

con <- DBI::dbConnect(RSQLite::SQLite(), dbname = "sqlite/author.sqlite")
db <- dplyr::tbl(con, "author")
author <- as.data.table(db)

# Save
save(author, file="datatable/author_dt.RData")