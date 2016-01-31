setwd("/home/renbin/Desktop/R/project2/")

NEI<-readRDS("summarySCC_PM25.rds")
#NEI<-readRDS("baltimore.rds")
NEI_Balti<-subset(NEI,fips=="24510")

NEI_year<-split(NEI_Balti, factor(NEI_Balti$year))
total_Em<-NULL

for(i in 1:length(unique(NEI_Balti$year)))total_Em<-c(total_Em, sum(NEI_year[[i]][,4]))

total_Em<-as.data.frame(total_Em)
rownames(total_Em)<-unique(NEI_Balti$year)
colnames(total_Em)<-"Emissions"
print(total_Em)

par(mfcol=c(1,1))

plot(total_Em$Emissions/1000, x=rownames(total_Em), pch=19, xlab="Year", ylab="Total PM2.5 Emissions (kilo-tons)", main="Total PM2.5 emissions in Baltimore", xaxt = "n")
axis(1, at=rownames(total_Em), labels=rownames(total_Em))
abline(lm(total_Em$Emissions/1000 ~ as.numeric(rownames(total_Em))), col="green", lwd=3)


dev.copy(png , file = "plot2.png", width=1024, height=768)
dev.off()   
