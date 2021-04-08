if (!file.exists("household_power_consumption.txt")){
        
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        
        download.file(fileURL, destfile = "power_consumption.zip")
        unzip("power_consumption.zip")
}

if(!require(dplyr)) install.packages("dplyr")
library(dplyr)

data <- read.csv2("household_power_consumption.txt") %>%
     subset(Date == "1/2/2007" | Date == "2/2/2007")

# Subset only the Global Active Power then make a histogram:
gap <- as.numeric(data$Global_active_power)

# Plotting
png("plot1.png", width = 480, height = 480)

par(mar = c(4,4,2,1))

hist(gap,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kiloWatts)")
rug(gap)

dev.off()