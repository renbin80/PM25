setwd("/home/renbin/Desktop/R/project2/")

## Read data
NEI<-readRDS("summarySCC_PM25.rds")

## Filter for Baltimore and "On-Road" sources, assuming that Motor Vehicles are defined losely as such. 
NEI_Balti<-subset(NEI,fips=="24510" & type=="ON-ROAD")

## Split commonCoalSources by year
NEI_year<-split(NEI_Balti, factor(NEI_Balti$year))

total_Em<-NULL
# Sum up emissions for each year and put it into total_Em vector
for(i in 1:length(unique(NEI_Balti$year)))total_Em<-c(total_Em, sum(NEI_year[[i]][,4]))

# Convert to data frame
total_Em<-as.data.frame(total_Em)

# Give proper col and row names
rownames(total_Em)<-unique(NEI_Balti$year)
colnames(total_Em)<-"Emissions"

# Print data frame
print(total_Em)

# Set up plot
par(mfcol=c(1,1))
plot(total_Em$Emissions, x=rownames(total_Em), pch=19, xlab="Year", ylab="Total PM2.5 Emissions (tons)", main="Motor Vehicle sources in Baltimore", xaxt = "n")
axis(1, at=rownames(total_Em), labels=rownames(total_Em))

# Add regression line
abline(lm(total_Em$Emissions ~ as.numeric(rownames(total_Em))), col="orange", lwd=3)

# Copy to PNG and save file
dev.copy(png , file = "plot5.png", width=1024, height=768)
dev.off()   
