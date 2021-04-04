library("tidyverse")
library("data.table")

con <- DBI::dbConnect(RSQLite::SQLite(), dbname = "sqlite/pmc.sqlite")
db <- dplyr::tbl(con, "pmc")
pmc <- as.data.table(db)

# Save
save(pmc, file="datatable/pmc_dt.RData")