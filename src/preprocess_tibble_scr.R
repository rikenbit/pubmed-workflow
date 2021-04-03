library("data.table")
library("tidyverse")

# Setting
input = commandArgs(trailingOnly=TRUE)[1]
output = commandArgs(trailingOnly=TRUE)[2]

# input = "data/pubmed/scr_medline16n0392.txt"

# Load
scr <- fread(input, stringsAsFactors=FALSE, header=FALSE)
target <- apply(scr, 2, function(x){
	all(!is.na(x))
})
scr <- as_tibble(scr[, ..target])

# Save
colnames(scr) <- c("PMID", "SCRID", "SCRTerm")
save(scr, file=output)