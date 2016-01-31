# Set working directory
setwd("/home/renbin/Desktop/R/project2/")

# Read data from RDS file
#NEI<-readRDS("summarySCC_PM25.rds")

# Subset using Baltimore code
mm<-subset(NEI,fips=="24510")

# Getting type of emissions sources and year
t<-c(unique(mm$type))
y<-c(unique(mm$year))

e<-NULL
mat<-NULL

# Using emission type and year, loop
for(j in 1:length(unique(mm$type))) {
     for(i in 1:length(unique(mm$year))){
          e<-NULL
          
          # Subset database by source type and year
          m<-subset(mm,mm$type==t[i] & mm$year==y[j])
          # Put year, type ad sum up emissions into vector e
          e<-c(y[j],t[i],sum(m$Emissions))
          # Add this vector e to matrix mat
          mat<-rbind(mat,e)
     }     
}

# Give matrix appropriate col and row names
colnames(mat)<-c("Year","Type","Emissions")
rownames(mat)<-NULL

# Convert matrix to data frame
mm<-as.data.frame(mat)

# Give data frame appropriate col and row names
mm$Year<-as.numeric(as.character(mm$Year))
mm$Emissions<-as.numeric(as.character(mm$Emissions))

# Print data frame
print(mm)

# Start ggplot
q<-ggplot(mm, aes(Year, Emissions)) + 
     # Use points, and facets based on type of emission
     geom_point() + facet_grid(.~Type) + 
     # Add regression line
     geom_smooth(method="lm", se=FALSE, col="purple") + 
     # Break at year
     scale_x_continuous(breaks=year)+
     # Label axis and title
     labs(y = "Total PM2.5 Emissions (tons)",
          title = "Emissions types in Baltimore") +
     # Adjust text in axis and title
     theme(title=element_text(size=20), axis.text=element_text(size=11), axis.title=element_text(size=16,face="bold"))

# Print ggplot object
print(q)

# Copy to PNG and save file
dev.copy(png , file = "plot3.png", width=1024, height=768)
dev.off()   