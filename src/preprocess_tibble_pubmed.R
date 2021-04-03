library("data.table")
library("tidyverse")

# Setting
input = commandArgs(trailingOnly=TRUE)[1]
output = commandArgs(trailingOnly=TRUE)[2]

# input = "data/pubmed/pubmed_medline16n0392.txt"

# Load
pubmed <- fread(input, stringsAsFactors=FALSE, header=FALSE)
target <- apply(pubmed, 2, function(x){
	all(!is.na(x))
})
pubmed <- as_tibble(pubmed[, ..target])

# Save
colnames(pubmed) <- c("PMID", "Journal", "Year", "Title", "Abstract")
save(pubmed, file=output)