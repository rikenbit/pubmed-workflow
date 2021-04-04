library("tidyverse")
library("data.table")

con <- DBI::dbConnect(RSQLite::SQLite(), dbname = "sqlite/scr.sqlite")
db <- dplyr::tbl(con, "scr")
scr <- as.data.table(db)

# Save
save(scr, file="datatable/scr_dt.RData")