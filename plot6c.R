# Seet working directory
setwd("/home/renbin/Desktop/R/project2/")

# Read data
NEI<-readRDS("summarySCC_PM25.rds")

## Filter for Baltimore and "On-Road" sources, assuming that Motor Vehicles are defined losely as such. 
NEI_Balti<-subset(NEI,fips=="24510" & type=="ON-ROAD")
## Filter for Los Angeles and "On-Road" sources, assuming that Motor Vehicles are defined losely as such. 
NEI_LA<-subset(NEI,fips=="06037" & type=="ON-ROAD")

## Split Baltimore sources by year
NEI_year<-split(NEI_Balti, factor(NEI_Balti$year))

Balti_Em<-NULL

# Sum up emissions for each year and put it into Balti_Em vector
for(i in 1:length(unique(NEI_Balti$year))) Balti_Em<-c(Balti_Em, sum(NEI_year[[i]][,4]))

## Split LA sources by year
NEI_year<-split(NEI_LA, factor(NEI_LA$year))

LA_Em<-NULL
# Sum up emissions for each year and put it into LA_Em vector
for(i in 1:length(unique(NEI_LA$year))) LA_Em<-c(LA_Em, sum(NEI_year[[i]][,4]))

# Create data frame using year and both Baltimore and LA vectors
total_Em<-as.data.frame(cbind(unique(NEI_LA$year),Balti_Em, LA_Em))

# Give proper col and row names
colnames(total_Em)<-c("year","Baltimore", "LA")

print(total_Em)

# Using reshape library
library(reshape2)

# Convert wide data frame to long form for plotting
melted <- melt(total_Em, id = "year")

# Give proper names to long data frame
names(melted)<-c("year", "City", "Emissions")
print(melted)

# Set up plot 
par(mfcol=c(1,1))

q<-ggplot(data=melted, aes(x=year, y=Emissions, color=City))+
     # Plot bar graphs
          geom_bar(stat="identity", aes(y=Emissions, fill=City), position="dodge", alpha=0.5)+
     # Add regressioin line
          stat_smooth(method = "lm")+
     # Break at year on x-axis
     
          scale_x_continuous(breaks=year)+
     # Convert to log scale for better viewing
          scale_y_log10()+   
     
     # Add emission amount on bars
     geom_text(aes(y=Emissions, label=round(Emissions)), vjust=1.6, color="black", size=5)+
     
     # Adjust labels
     labs(y = "Total PM2.5 Emissions (Log(tons))",
          x = "\nYear",
          title = "Motor vehicle emissions in Baltimore and Los Angeles") +
     # Adjust text sizes
     theme(title=element_text(size=20), axis.text=element_text(size=14), axis.title=element_text(size=16,face="bold"))

# Print ggplot object
print(q)

# Copy to PNG and save file
dev.copy(png , file = "plot6.png", width=1024, height=768)
dev.off()   
