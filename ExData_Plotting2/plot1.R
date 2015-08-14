#PREREQUISITES
library(plyr)
library(ggplot2)
library(data.table)

dat1 <- readRDS("summarySCC_PM25.rds")
dat2 <- readRDS("Source_Classification_Code.rds")
## Convert into data.table
dat1.dt = data.table(dat1)
dat2.dt = data.table(dat2)

#PROBLEM 1

total.emissions <- with(dat1, aggregate(Emissions, by = list(year), sum))

png(filename = "plot1.png", width = 480, height = 480, units = "px")

plot(total.emissions, type = "b", pch = 18, col = "green", ylab = "Emissions", 
     xlab = "Year", main = "Annual Emissions")

dev.off()

