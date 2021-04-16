if(!file.exists("summarySCC_PM25.rds")){
     fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
     
     download.file(fileURL, destfile = "exdata_data_NEI_data.zip")
     unzip("exdata_data_NEI_data.zip")
}

NEI <- readRDS("summarySCC_PM25.rds")

# Emissions Per Year
epy <- with(NEI, aggregate(Emissions ~ year, FUN = sum))

par(mar = c(4,4,2,1))
png("plot1.png")

with(epy, barplot(height = Emissions/1000,
                  names.arg = year,
                  ylim = c(0, 8000)))

title(main = "Total Emission of PM2.5 per Year",
      xlab = "Years",
      ylab = "Emissions of PM2.5 (kilotons)")

dev.off()