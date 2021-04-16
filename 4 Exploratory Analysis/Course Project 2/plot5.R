if(!file.exists("summarySCC_PM25.rds")){
     fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
     
     download.file(fileURL, destfile = "exdata_data_NEI_data.zip")
     unzip("exdata_data_NEI_data.zip")
}

if(!require(dplyr)) install.packages("dplyr")
library(dplyr)

if(!require(ggplot2)) install.packages("ggplot2")
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

veh <- readRDS("Source_Classification_Code.rds") %>%
     subset(grepl("vehicle", EI.Sector, ignore.case = TRUE)) %>% 
     select(SCC)

vehicle.emissions <- subset(NEI, SCC %in% veh$SCC)

png("plot5.png")

ggplot(vehicle.emissions,
       aes(x = factor(year),
           y = Emissions/1000,
           fill = year)) +
     geom_bar(stat = "identity") +
     labs(title = "Emissions from motor vehicle sources",
          x = "Years",
          y = "Emissions of PM2.5 (kilotons)")

dev.off()