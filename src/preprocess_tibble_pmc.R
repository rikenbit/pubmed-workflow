library("data.table")
library("tidyverse")

# Setting
input = commandArgs(trailingOnly=TRUE)[1]
output = commandArgs(trailingOnly=TRUE)[2]

# input = "data/pubmed/pmc_medline16n0392.txt"

# Load
pmc <- fread(input, stringsAsFactors=FALSE, header=FALSE)
target <- apply(pmc, 2, function(x){
	all(!is.na(x))
})
pmc <- as_tibble(pmc[, ..target])

# Save
colnames(pmc) <- c("PMID", "PMCID")
save(pmc, file=output)