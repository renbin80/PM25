nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
scc$SCC <- as.character(scc$SCC)
#nei$year <- as.factor(nei$year)
# Get coal related entries (239 records) from SCC and also get only the required two columns to make the join easier and less memory intensive
scc_coal <- scc[grep("Coal", scc$Short.Name, ignore.case = TRUE), c("SCC","Short.Name")]
str(scc_coal)
# Merge two data sets (53,400 records)
##### Merging data!
nei_coal <- merge(x = nei, y = scc_coal, by.x = "SCC", by.y = "SCC")
# Total coal combustion related emissions by year
nei_coal_year <- aggregate(Emissions ~ year, nei_coal, sum)
png("plot4.png", 480, 480)
barplot(nei_coal_year$Emissions, names.arg = nei_coal_year$year, xlab = "Year", ylab = "Emissions", main="Emissions for Coal Combustion related sources", col = "green")
dev.off()
