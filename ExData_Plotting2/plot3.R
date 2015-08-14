#PREREQUISITES
library(plyr)
library(ggplot2)
library(data.table)

dat1 <- readRDS("summarySCC_PM25.rds")
dat2 <- readRDS("Source_Classification_Code.rds")
## Convert into data.table
dat1.dt = data.table(dat1)
dat2.dt = data.table(dat2)

#PROBLEM 3

temp <- dat1[which(dat1$fips == "24510"), ]
total.emissions.baltimore <- with(temp, aggregate(Emissions, by = list(year),  sum))
colnames(total.emissions.baltimore) <- c("year", "Emissions")

total.emissions.baltimore.type <- ddply(temp, .(type, year), summarize, 
                                        Emissions = sum(Emissions))
total.emissions.baltimore.type$Pollutant_Type <- total.emissions.baltimore.type$type

png(filename='plot3.png', width=480, height=480, units='px')

qplot(year, Emissions, data = total.emissions.baltimore.type, group = Pollutant_Type, color = Pollutant_Type, geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]),  xlab = "Year", main = "Total Emissions in U.S. by Type of Pollutant")
dev.off()