library("tidyverse")
library("data.table")

con <- DBI::dbConnect(RSQLite::SQLite(), dbname = "sqlite/abstract.sqlite")
db <- dplyr::tbl(con, "abstract")
abstract <- as.data.table(db)

# Save
save(abstract, file="datatable/abstract_dt.RData")