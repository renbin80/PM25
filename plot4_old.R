setwd("/home/renbin/Desktop/R/project2/")

## Read data
NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")

## Filter for "Coal" in entries, but ignoring coal "Mining". Assuming "Mining" activity for coal does not use coal as source. 
coalSCC<-subset(SCC, grepl("Coal",Short.Name) & !grepl("Mining",EI.Sector))

## Only interested in SCC digit strings
coalSCC<-coalSCC$SCC

## Find SCC strings that appear in both files
commonSCC<-intersect(coalSCC, NEI$SCC)


#Initialize dataframe
commonCoalSources<-NULL

# Go through main database and copy all entries with common SCC strings to commonCoalSources 
for(i in 1:length(commonSCC)){ 
     temp<-NULL
     #Subset by comparing SCC strings
     temp<-subset(NEI, NEI$SCC == commonSCC[i])
     #Store entries to commonCoalSources
     commonCoalSources<-suppressWarnings(rbind(commonCoalSources, temp))
     
}

## Split commonCoalSources by year
NEI_year<-split(commonCoalSources, factor(commonCoalSources$year))

total_Em<-NULL

for(i in 1:length(unique(commonCoalSources$year))){ 
     year_Em<-NEI_year[[i]][,4]
     total_Em<-suppressWarnings(cbind(total_Em, year_Em))
     
}

colnames(total_Em)<-unique(NEI$year)

plot(colSums(total_Em)/1000, x=colnames(total_Em), pch=19, xlab="Year", ylab="Total PM2.5 Emissions (kilo-tons)", main="Total PM2.5 emissions from coal combustion-related sources in USA", xaxt = "n")
axis(1, at=colnames(total_Em), labels=colnames(total_Em))
abline(lm(colSums(total_Em)/1000 ~ as.numeric(colnames(total_Em))), col="red", lwd=3)

dev.copy(png , file = "plot4.png")
dev.off()
