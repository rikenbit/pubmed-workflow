library("tidyverse")
library("data.table")

con <- DBI::dbConnect(RSQLite::SQLite(), dbname = "sqlite/qualifier.sqlite")
db <- dplyr::tbl(con, "qualifier")
qualifier <- as.data.table(db)

# Save
save(qualifier, file="datatable/qualifier_dt.RData")