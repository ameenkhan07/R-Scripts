#PREREQUISITES
library(plyr)
library(ggplot2)
library(data.table)

dat1 <- readRDS("summarySCC_PM25.rds")
dat2 <- readRDS("Source_Classification_Code.rds")
## Convert into data.table
dat1.dt = data.table(dat1)
dat2.dt = data.table(dat2)

#PROBLEM 4
coal = dat2.dt[grep("Coal", SCC.Level.Three), SCC]

coal.emissions = dat1.dt[SCC %in% coal, sum(Emissions), by = "year"]
colnames(coal.emissions) <- c("year", "Emissions")

png(filename = "plot4.png", width = 480, height = 480, units = "px")

g = ggplot(coal.emissions, aes(year, Emissions))
g + geom_point(color = "red") + geom_line(color = "green") + labs(x = "Year") + 
  labs(y = expression("Total Emissions, PM"[2.5])) + labs(title = "Emissions from Coal Combustion for the US")

dev.off()