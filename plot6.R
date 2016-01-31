setwd("/home/renbin/Desktop/R/project2/")

## Read data
#NEI<-readRDS("summarySCC_PM25.rds")

## Filter for Baltimore and "On-Road" sources, assuming that Motor Vehicles are defined losely as such. 
NEI_Balti<-subset(NEI,fips=="24510" & type=="ON-ROAD")

## Filter for Baltimore and "On-Road" sources, assuming that Motor Vehicles are defined losely as such. 
NEI_LA<-subset(NEI,fips=="06037" & type=="ON-ROAD")



## Split Baltimore sources by year
NEI_year<-split(NEI_Balti, factor(NEI_Balti$year))

Balti_Em<-NULL
for(i in 1:length(unique(NEI_Balti$year))) Balti_Em<-c(Balti_Em, sum(NEI_year[[i]][,4]))

## Split LA sources by year
NEI_year<-split(NEI_LA, factor(NEI_LA$year))

LA_Em<-NULL
for(i in 1:length(unique(NEI_LA$year))) LA_Em<-c(LA_Em, sum(NEI_year[[i]][,4]))

total_Em<-as.data.frame(cbind(Balti_Em, LA_Em))

rownames(total_Em)<-unique(NEI_Balti$year)
colnames(total_Em)<-c("Baltimore Emissions", "LA Emissions")


dev.new(width=8, height=4)
par(mfcol=c(1,2))

print(total_Em)



plot(total_Em$`Baltimore Emissions`, x=rownames(total_Em), pch=19, xlab="Year", ylab="Total PM2.5 Emissions (tons)", main="Motor Vehicle sources in Baltimore", xaxt = "n")
axis(1, at=rownames(total_Em), labels=rownames(total_Em))
abline(lm(total_Em$`Baltimore Emissions` ~ as.numeric(rownames(total_Em))), col="cyan", lwd=3)


plot(total_Em$`LA Emissions`, x=rownames(total_Em), pch=19, xlab="Year", ylab="Total PM2.5 Emissions (tons)", main="Motor Vehicle sources in LA", xaxt = "n")
axis(1, at=rownames(total_Em), labels=rownames(total_Em))
abline(lm(total_Em$`LA Emissions` ~ as.numeric(rownames(total_Em))), col="cyan", lwd=3)


dev.copy(png , file = "plot6.png", width=1024, height=768)
dev.off()   
