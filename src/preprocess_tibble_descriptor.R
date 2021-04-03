library("data.table")
library("tidyverse")

# Setting
input = commandArgs(trailingOnly=TRUE)[1]
output = commandArgs(trailingOnly=TRUE)[2]

# input = "data/pubmed/descriptor_medline16n0392.txt"

# Load
descriptor <- fread(input, stringsAsFactors=FALSE, header=FALSE)
target <- apply(descriptor, 2, function(x){
	all(!is.na(x))
})
descriptor <- as_tibble(descriptor[, ..target])

# Save
colnames(descriptor) <- c("PMID", "DescriptorID", "DescriptorTerm")
save(descriptor, file=output)