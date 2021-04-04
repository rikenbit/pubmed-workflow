library("tidyverse")
library("data.table")

con <- DBI::dbConnect(RSQLite::SQLite(), dbname = "sqlite/descriptor.sqlite")
db <- dplyr::tbl(con, "descriptor")
descriptor <- as.data.table(db)

# Save
save(descriptor, file="datatable/descriptor_dt.RData")