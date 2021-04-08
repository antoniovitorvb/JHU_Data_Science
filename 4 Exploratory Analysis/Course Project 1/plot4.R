if (!file.exists("household_power_consumption.txt")){
     
     fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
     
     download.file(fileURL, destfile = "power_consumption.zip")
     unzip("power_consumption.zip")
}

if(!require(dplyr)) install.packages("dplyr")
library(dplyr)

data <- read.csv2("household_power_consumption.txt") %>%
     subset(Date == "1/2/2007" | Date == "2/2/2007")

# Subset the necessary variables:
gap <- as.numeric(data$Global_active_power)
grp <- as.numeric(data$Global_reactive_power)
V <- as.numeric(data$Voltage)

time <- strptime(paste(data$Date, data$Time, sep = " "),
                 format = "%d/%m/%Y %H:%M:%S")

sub_meter <- data %>%
     select(Sub_metering_1:Sub_metering_3)

# Plotting
png("plot4.png", width = 480, height = 480)

par(mfrow = c(2,2),
    mar = c(4,4,2,1),
    oma = c(0,0,2,0))

# 1st PLOT
plot(x = time,
     y = gap,
     type = "l",
     ylab = "Global Active Power")

# 2nd PLOT
plot(x = time,
     y = V,
     type = "l",
     ylab = "Voltage")

# 3rd PLOT
plot(x = time,
     y = sub_meter$Sub_metering_1,
     type = "n",
     ylab = "Energy sub metering")

colours <- c("black", "red", "blue")

for (i in 1:3) {
     ## converts each each column into numeric preserving sub_meter as data.frame
     sub_meter[,i] <- as.numeric(sub_meter[,i])
     
     ## add to the plot each sub metering
     lines(x = time,
           y = sub_meter[,i],
           col = colours[i])
}

legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd = 2, 
       col = c("black", "red", "blue"))

# 4th PLOT
plot(x = time,
     y = grp,
     type = "l",
     ylab = "Global Reactive Power")

# finish plots
dev.off()
