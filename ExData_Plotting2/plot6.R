#PREREQUISITES
library(plyr)
library(ggplot2)
library(data.table)

dat1 <- readRDS("summarySCC_PM25.rds")
dat2 <- readRDS("Source_Classification_Code.rds")
## Convert into data.table
dat1.dt = data.table(dat1)
dat2.dt = data.table(dat2)

#PROBLEM 5

motor.vehicle.scc = dat2.dt[grep("[Mm]obile|[Vv]ehicles", EI.Sector), SCC]

motor.vehicle.emissions.baltimore = dat1.dt[dat2 %in% motor.vehicle.scc, sum(Emissions), 
                                            by = c("year", "fips")][fips == "24510"]
colnames(motor.vehicle.emissions.baltimore) <- c("year", "fips", "Emissions")

png(filename = "plot5.png", width = 480, height = 480, units = "px")

g = ggplot(motor.vehicle.emissions.baltimore, aes(year, Emissions))
g + geom_point(color = "red") + geom_line(color = "green") + labs(x = "Year") + 
  labs(y = expression("Total Emissions, PM"[2.5])) + labs(title = "Total Emissions from Motor Vehicle Sources in Baltimore City")

dev.off()