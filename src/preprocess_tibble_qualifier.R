library("data.table")
library("tidyverse")

# Setting
input = commandArgs(trailingOnly=TRUE)[1]
output = commandArgs(trailingOnly=TRUE)[2]

# input = "data/pubmed/qualifier_medline16n0392.txt"

# Load
qualifier <- fread(input, stringsAsFactors=FALSE, header=FALSE)
target <- apply(qualifier, 2, function(x){
	all(!is.na(x))
})
qualifier <- as_tibble(qualifier[, ..target])

# Save
colnames(qualifier) <- c("PMID", "QualifierID", "QualifierTerm")
save(qualifier, file=output)