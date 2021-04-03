library("ggplot2")

types <- c("pubmed", "pmc", "descriptor", "qualifier", "scr")
tibbledata <- paste0("tibble/", types, ".RData")
for(i in seq(tibbledata)){
	load(tibbledata[i])
}
values <- c(nrow(pubmed), nrow(pmc), nrow(descriptor),
	nrow(qualifier), nrow(scr))

gdata <- data.frame(Name=types, Value=values)
gdata$Name <- factor(types, level=types)

# Plot
g <- ggplot(gdata, aes(x = Name, y = Value, fill = Name)) +
    geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + xlab("Types") + ylab("# count") + theme(plot.margin= unit(c(1, 1, -1, 1), "lines"))

ggsave(file='plot/summary.png', plot=g,
	dpi=500, width=20.0, height=7.0)
