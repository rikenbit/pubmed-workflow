library("ggplot2")
library("RSQLite")

types <- c("pubmed", "author", "abstract", "pmc", "descriptor", "qualifier", "scr")

sqlitedata <- paste0("sqlite/", types, ".sqlite")
values <- c()
for(i in seq(sqlitedata)){
	con <- dbConnect(SQLite(), sqlitedata[i])
	query <- paste0("SELECT COUNT(*) FROM ", types[i])
	values <- c(values, dbGetQuery(con, query))
	dbDisconnect(con)
}
values <- as.vector(unlist(values))
gdata <- data.frame(Name=types, Value=values)
gdata$Name <- factor(types, level=types)

# Plot
g <- ggplot(gdata, aes(x = Name, y = Value, fill = Name)) +
    geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + xlab("") + ylab("# counts") + theme(plot.margin= unit(c(1, 1, -1, 1), "lines")) + theme(legend.position = 'none') + theme(text = element_text(size = 24))

ggsave(file='plot/summary.png', plot=g, dpi=500, width=20.0, height=8.0)
