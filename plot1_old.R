setwd("/home/renbin/Desktop/R/project2/")

#NEI<-readRDS("summarySCC_PM25.rds")
#NEI<-readRDS("mydata.rds")

#print (NEI)
#SCC <- readRDS("Source_Classification_Code.rds")
#top<-head(NEI,10)
#bot<-tail(NEI,10)
#NEI<-rbind(top, bot)
NEI_year<-split(NEI, factor(NEI$year))
total_Em<-NULL

for(i in 1:length(unique(NEI$year))){ 
     year_Em<-NEI_year[[i]][,4]
     print(length(year_Em))
     
     total_Em<-suppressWarnings(cbind(total_Em, year_Em))

}
colnames(total_Em)<-unique(NEI$year)

# png("plot1.png", units = "px", width=640, height=480)

plot(colSums(total_Em)/1000000, x=colnames(total_Em), pch=19, xlab="Year", ylab="Total PM2.5 Emissions (Million-tons)", main="Total PM2.5 emissions in USA", xaxt = "n")
axis(1, at=colnames(total_Em), labels=colnames(total_Em))
abline(lm(colSums(total_Em)/1000000 ~ as.numeric(colnames(total_Em))), col="blue", lwd=3)

dev.copy(png , file = "plot4.png")
dev.off()   