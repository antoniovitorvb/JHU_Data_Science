# Dates and Time

x<-as.Date("1970-01-01") # change str to Date

x<-Sys.time() # actual time of the system
     # "YYY-MM-DD hh:mm:ss utf"
class(x)

datestring <- c("Januaty 10, 2012 10:40", "December 9, 2011 9:10")
x <- strptime(datestring, format = "%B %d, %Y %H:%M")
     # ?strptime for details of each %_