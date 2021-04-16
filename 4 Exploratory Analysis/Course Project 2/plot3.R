if(!file.exists("summarySCC_PM25.rds")){
     fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
     
     download.file(fileURL, destfile = "exdata_data_NEI_data.zip")
     unzip("exdata_data_NEI_data.zip")
}

if(!require(dplyr)) install.packages("dplyr")
library(dplyr)

if(!require(ggplot2)) install.packages("ggplot2")
library(ggplot2)

bal <- readRDS("summarySCC_PM25.rds") %>%
     subset(fips == "24510")

png("plot3.png")

ggplot(with(bal,
            aggregate(Emissions ~ year + type,
                      FUN = sum)),
       aes(x = year,
           y = Emissions,
           color = type)) +
     geom_line(size = 1.5) +
     labs(title = "Emissions of PM2.5 for each type in Baltimore City, MD per Year",
          x = "Years",
          y = "Emissions of PM2.5 (tons)")

dev.off()