# Set working directory
setwd("/home/renbin/Desktop/R/project2/")

# Read data from RDS file
NEI<-readRDS("summarySCC_PM25.rds")

# Subset dataset using Baltimore code
NEI_Balti<-subset(NEI,fips=="24510")

# Split dataset by year
NEI_year<-split(NEI_Balti, factor(NEI_Balti$year))

# Sum up emissions for each year and put it into total_Em vector
total_Em<-NULL
for(i in 1:length(unique(NEI_Balti$year)))total_Em<-c(total_Em, sum(NEI_year[[i]][,4]))

# Convert total_Em vector into data frame
total_Em<-as.data.frame(total_Em)

# Use appropriate names for col and row in data frame
rownames(total_Em)<-unique(NEI_Balti$year)
colnames(total_Em)<-"Emissions"

# Print out data frame
print(total_Em)

# Set up plot
par(mfcol=c(1,1))

# Plot Emissions vs Year
plot(total_Em$Emissions/1000, x=rownames(total_Em), pch=19, xlab="Year", ylab="Total PM2.5 Emissions (kilo-tons)", main="Total PM2.5 emissions in Baltimore", xaxt = "n")
axis(1, at=rownames(total_Em), labels=rownames(total_Em))

# Add regression line
abline(lm(total_Em$Emissions/1000 ~ as.numeric(rownames(total_Em))), col="green", lwd=3)

# Copy to PNG and save file
dev.copy(png , file = "plot2.png", width=1024, height=768)
dev.off()   
