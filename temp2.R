vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]
vehiclesBaltimoreNEI <- vehiclesNEI[vehiclesNEI$fips=="24510",]
vehiclesBaltimoreNEI$city <- "Baltimore"
vehiclesLosAngNEI <- vehiclesNEI[vehiclesNEI$fips=="06037",]
vehiclesLosAngNEI$city <- "Los Angeles"
BaltLosAng <- rbind(vehiclesBaltimoreNEI,vehiclesLosAngNEI)
library(ggplot2)
BaltLosAngPlot <- ggplot(BaltLosAng, aes(x=factor(year), y=Emissions, fill=city)) +
     geom_bar(aes(fill=year),stat="identity") +
     facet_grid(scales="free", space="free", .~city) +
     guides(fill=FALSE) + theme_bw() +
     labs(x="year", y=expression("Total PM"[2.5]*" emissions Tx10^3")) + 
     labs(title=expression("PM"[2.5]*" Motor Vehicle emissions, Baltimore-Los Angeles, 1999-2008"))
print(BaltLosAngPlot)