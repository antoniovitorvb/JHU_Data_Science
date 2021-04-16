if(!file.exists("summarySCC_PM25.rds")){
     fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
     
     download.file(fileURL, destfile = "exdata_data_NEI_data.zip")
     unzip("exdata_data_NEI_data.zip")
}

if(!require(dplyr)) install.packages("dplyr")
library(dplyr)

if(!require(ggplot2)) install.packages("ggplot2")
library(ggplot2)

# NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

# NEI from LA and Baltimore
la.bal <- readRDS("summarySCC_PM25.rds") %>%
     subset(fips == "06037" | fips == "24510")

veh <- readRDS("Source_Classification_Code.rds") %>%
     subset(grepl("vehicle", EI.Sector, ignore.case = TRUE)) %>% 
     select(SCC)

vehicle.emissions <- subset(la.bal, SCC %in% veh$SCC)

png("plot6.png")
ggplot(with(vehicle.emissions,
            aggregate(Emissions ~ fips + year,
                      FUN = sum)),
       aes(x = year,
           y = Emissions/1000,
           color = fips)) +
        geom_line(size = 1.5) +
        labs(title = "Emissions from motor vehicle sources - LA Vs. Baltimore",
             x = "Years",
             y = "Emissions of PM2.5 (kilotons)")

dev.off()