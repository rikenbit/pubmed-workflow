library("tidyverse")
library("data.table")

con <- DBI::dbConnect(RSQLite::SQLite(), dbname = "sqlite/pubmed.sqlite")
db <- dplyr::tbl(con, "pubmed")
pubmed <- as.data.table(db)

# Save
save(pubmed, file="datatable/pubmed_dt.RData")