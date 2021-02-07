if (file.exists(paste(getwd(), "/rprog_data_specdata.zip", sep = ""))){
     unzip("rprog_data_specdata.zip")
}

if (!require("readr")) {install.packages("readr")}
library(readr)

pollutantmean <- function(directory, pollutant, id = 1:332){
     allFiles <- list.files(path = directory, full.names = TRUE)
     selectedData <- data.frame() # Initializes dataframe
     
     for (i in id){
          if (tolower(pollutant) == "sulfate"){
               rawdata <- read_csv(directory,
                                   col_types = do.call(cols_only,
                                                       list(Date = "D", 
                                                            sulfate = 'n')))
          } else if (tolower(pollutant) == "nitrate") {
               rawdata <- read_csv(directory,
                                   col_types = do.call(cols_only,
                                                       list(Date = "D", 
                                                            nitrate = 'n')))
          }
          
          selectedData <- rbind(selectedData, rawdata)
     }
     
     colnames(selectedData) <- c("Date", "pollutant")
     mean(selectedData$pollutant, na.rm = TRUE)
}