# Set working directory
setwd("/home/renbin/Desktop/R/project2/")

# Read data from both databases
NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")

# Filter for "Coal" in entries, but ignoring coal "Mining". Assuming "Mining" activity for coal does not use coal as source. 
coalSCC<-subset(SCC, grepl("Coal",Short.Name) & !grepl("Mining",EI.Sector))

# Only interested in SCC digit strings
coalSCC<-coalSCC$SCC

# Find SCC strings that appear in both files
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
# Sum up emissions for each year and put it into total_Em vector
for(i in 1:length(unique(commonCoalSources$year)))total_Em<-c(total_Em, sum(NEI_year[[i]][,4]))

# Convert to data frame
total_Em<-as.data.frame(total_Em)

# Give proper col and row names to data frame
rownames(total_Em)<-unique(commonCoalSources$year)
colnames(total_Em)<-"Emissions"

# Print data frame
print(total_Em)

# Set up plot
par(mfcol=c(1,1))
plot(total_Em$Emissions/1000, x=rownames(total_Em), pch=19, xlab="Year", ylab="Total PM2.5 Emissions (kilo-tons)", main="Coal combustion-related sources in USA", xaxt = "n")
axis(1, at=rownames(total_Em), labels=rownames(total_Em))
# Add regression line
abline(lm(total_Em$Emissions/1000 ~ as.numeric(rownames(total_Em))), col="red", lwd=3)

# Copy to PNG and save file
dev.copy(png , file = "plot4.png", width=1024, height=768)
dev.off()   
