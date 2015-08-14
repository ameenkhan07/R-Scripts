#PREREQUISITES
library(plyr)
library(ggplot2)
library(data.table)

dat1 <- readRDS("summarySCC_PM25.rds")
dat2 <- readRDS("Source_Classification_Code.rds")
## Convert into data.table
dat1.dt = data.table(dat1)
dat2.dt = data.table(dat2)

#PROBLEM 2

temp <- dat1[which(dat1$fips == "24510"), ]
total.emissions.baltimore <- with(temp, aggregate(Emissions, by = list(year), sum))
colnames(total.emissions.baltimore) <- c("year", "Emissions")

png(filename = "plot2.png", width = 480, height = 480, units = "px")

plot(total.emissions.baltimore$year, total.emissions.baltimore$Emissions, type = "b", pch = 18, col = "green", ylab = "Emissions", xlab = "Year", main = "Baltimore Emissions")

dev.off()

