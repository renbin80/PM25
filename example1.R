#plot 1
library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

sum.yearly.em.df <- NEI %>% group_by(year) %>% summarise(sum_em = sum(Emissions)) %>% as.data.frame()

png('plot1.png', width = 480, height = 480, units = 'px') 
plot(sum.yearly.em.df)
dev.off()