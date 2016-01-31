setwd("C:/Users/renbin/Desktop/R/Project2")

#NEI<-readRDS("summarySCC_PM25.rds")
NEI<-readRDS("baltimore.rds")
#NEI<-subset(NEI,fips=="24510")
NEI_temp<-split(NEI, factor(NEI$type))
NEI_type[1]<-NEI_temp[4]

total_Em<-NULL

hello<-function(outcome, num="best"){
     print(outcome)
     
}



hello("sf")