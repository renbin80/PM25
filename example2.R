#plot 1
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

a<-aggregate(Emissions ~ year, NEI, sum )
print(a)
plot(a)
