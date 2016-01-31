# get files from:https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
#plot 1
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")



a<-aggregate(Emissions ~ year, NEI, sum )
print(a)
plot(a)
