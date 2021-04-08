fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileURL, destfile = "power_consumption.zip")
unzip("power_consumption.zip")

data <-read.csv2("household_power_consumption.txt")
data$Date <- strptime(data$Date, format = "%d/%m/%Y")

subdata <- data[data$Date == "2007-02-01" | data$Dates == "2007-02-02"]