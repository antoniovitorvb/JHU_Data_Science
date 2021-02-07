if (file.exists(paste(getwd(), "/rprog_data_specdata.zip", sep = ""))){
     unzip("rprog_data_specdata.zip")
}

# libs<-c("readr", "ggplot2", "reshape2")
# if (!require(libs)) {install.packages(libs)}
library(readr)
library(ggplot2)
library(reshape2)

pollutantmean1 <- function(directory, pollutant, id = 1:332){
     t0<-Sys.time()
     allFiles <- list.files(path = directory, full.names = TRUE)
     selectedData <- data.frame() # Initializes dataframe
     
     for (i in id){
          if (tolower(pollutant) == "sulfate"){
               rawdata <- read_csv(allFiles[i],
                                   col_types = do.call(cols_only,
                                                       list(Date = "D", 
                                                            sulfate = 'n')))
          } else if (tolower(pollutant) == "nitrate") {
               rawdata <- read_csv(allFiles[i],
                                   col_types = do.call(cols_only,
                                                       list(Date = "D", 
                                                            nitrate = 'n')))
          }
          selectedData <- rbind(selectedData, rawdata)
     }
     colnames(selectedData) <- c("Date", "pollutant")
     mean(selectedData$pollutant, na.rm = TRUE)
     Sys.time()-t0
}

pollutantmean2 <- function(directory,pollutant,id = 1:332){
     t0 <- Sys.time()
     allFiles <- list.files(path = directory, full.names = TRUE)
     selectedData <- data.frame()
     
     for (i in id) {
          selectedData <- rbind(selectedData, read.csv(allFiles[i]))
     }
     if (pollutant == 'sulfate') {
          mean(selectedData$sulfate, na.rm = TRUE)
     } else if (pollutant == 'nitrate') {
          mean(selectedData$nitrate, na.rm = TRUE)
     }
     Sys.time()-t0
}

t<-data.frame(CSVs = 0, pol1 = 0, pol2 = 0)
t0<-Sys.time()
for (count in 1:332){
     t<-rbind(t, c(count,
                   pollutantmean1("specdata", "sulfate", 1:count),
                   pollutantmean2("specdata", "sulfate", 1:count)
                   )
              )
     print(ggplot(data = t,
                  aes(x = CSVs)) +
                geom_line(aes(y = pol1,
                              colour = "My Lean Code")) +
                geom_line(aes(y = pol2,
                              colour = "Example code")) +
                labs(title = "Battle of Codes",
                     x = "Number of .csv files",
                     y = "Time (s)")
           )
}
Sys.time()-t0