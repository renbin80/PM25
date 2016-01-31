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
colnames(total_Em)<-c("Baltimore", "LA")


par(mfcol=c(1,1))

print(total_Em)



# plot(total_Em$`Baltimore Emissions`, x=rownames(total_Em), ylim=c(0,5000),pch=19, xlab="Year", ylab="Total PM2.5 Emissions (tons)", main="Motor Vehicle sources in Baltimore", xaxt = "n")
# 
# 
# points(total_Em$`LA Emissions`, x=rownames(total_Em), pch=17, xlab="Year", ylab="Total PM2.5 Emissions (tons)", main="Motor Vehicle sources in LA")
# axis(1, at=rownames(total_Em), labels=rownames(total_Em))
# 
# abline(lm(total_Em$`Baltimore Emissions` ~ as.numeric(rownames(total_Em))), col="cyan", lwd=3)
# abline(lm(total_Em$`LA Emissions` ~ as.numeric(rownames(total_Em))), col="pink", lwd=3)



#q<-ggplot(total_Em, aes(x=as.numeric(rownames(total_Em)), y=total_Em$Baltimore)) 
     q<-ggplot(data=total_Em, aes(x=as.numeric(rownames(total_Em)))) +

#     geom_point(size=5, pch=2) +
          geom_bar(stat="identity", aes(y=total_Em$LA), fill="green", alpha=0.5)+
          geom_smooth(col="red", method="lm", se=FALSE, aes(x=as.numeric(rownames(total_Em)), y=total_Em$LA)) +
          geom_text(aes(label=round(total_Em$LA), y=total_Em$LA), vjust=1.6, color="black", size=5)+
          
          geom_bar(stat="identity", aes(y=total_Em$Baltimore), fill="steelblue", alpha=0.8)+
          geom_smooth(col="red", method="lm", se=FALSE, aes(x=as.numeric(rownames(total_Em)), y=total_Em$Baltimore)) +
          geom_text(aes(label=round(total_Em$Baltimore), y=total_Em$Baltimore), vjust=1.6, color="white", size=5)+
          theme(title=element_text(size=20), axis.text=element_text(size=14), axis.title=element_text(size=16,face="bold"))+ 
          
          #theme_minimal()+
          scale_x_continuous(breaks=as.numeric(rownames(total_Em)))+
          labs(y = "Total PM2.5 Emissions (Log(tons))",
               x = "\nYear",
               title = "Motor vehicle emissions in Baltimore and Los Angeles") +
          annotate("text", x = 2003.5, y = 2500, label = "Los Angeles", size=10) +
          annotate("text", x = 2003.5, y = 80, label = "Baltimore", size=10) +
          scale_y_log10()+
          guides(colour="legend")
     
     #geom_bar(stat="identity", aes(y=total_Em$Baltimore))
          
#      geom_smooth(col="purple", method="lm") +
#      geom_point(size=5, pch=3,aes(as.numeric(rownames(total_Em)), total_Em$LA)) +
#      geom_smooth(col="pink", method="lm", aes(x=as.numeric(rownames(total_Em)), y=total_Em$LA)) +
#      labs(y = "Total PM2.5 Emissions (tons)",
#           x = "Year",
#           title = "Emissions types in Baltimore and Los Angeles") + 
#      scale_x_continuous(breaks=as.numeric(rownames(total_Em)))+
#      theme(title=element_text(size=20), axis.text=element_text(size=14), axis.title=element_text(size=16,face="bold"))+ 
# 

print(q)




dev.copy(png , file = "plot6.png", width=1024, height=768)
dev.off()   
