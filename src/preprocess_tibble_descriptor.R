library("tidyverse")

con <- DBI::dbConnect(RSQLite::SQLite(), dbname = "sqlite/descriptor.sqlite")
db <- dplyr::tbl(con, "descriptor")
descriptor <- tibble::as_tibble(db)

# Save
save(descriptor, file="tibble/descriptor_tbl.RData")