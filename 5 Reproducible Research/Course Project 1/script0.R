if (!("rawData" %in% ls())){
        fileURL <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
        download.file(fileURL, destfile = "activity.zip")
        
        rawData <- unzip("activity.zip") %>%
                read.csv()
}

library(ggplot2)
library(dplyr)

activity <- rawData %>%
        mutate(date = as.Date(date), 
               weekday = weekdays(date))

# summary(activity)

## 1. What is mean total number of steps taken per day?
steps_sum <- with(activity, aggregate(steps, 
                                      by = list(date),
                                      FUN = sum,
                                      na.rm = TRUE))
png("plot1.png")
hist(steps_sum$x,
     main = "Total Number of Steps Taken per Day",
     xlab = "Number of Steps",
     breaks = seq(0,25000, by=2500),
     col = "darkred")
rug(steps_sum$x)
dev.off()

avg <- round(mean(steps_sum$x), 2)
med <- median(steps_sum$x)

## 2. What is the average daily activity pattern?

avg_daily <- with(activity, aggregate(steps, 
                                      by = list(interval),
                                      FUN = mean,
                                      na.rm = TRUE))
names(avg_daily) <- c("interval", "mean")
max_mean <- max(avg_daily$mean)

png("plot2.png")
ggplot(data = avg_daily,
       aes(x = interval, #interval
           y = mean)) + # mean 
        geom_line(size = 1,
                  color = "darkgreen") +
        labs(title = "Average Number of Steps Taken per Interval",
             x = "Interval (min)",
             y = "Average Number of Steps") +
        geom_point(aes(y = max(mean),
                       x = interval[mean == max_mean]),
                   size = 3,
                   color = "red") +
        geom_text(aes(y = max_mean + 5,
                      x = interval[mean == max(mean)] + 250,
                      label = paste("Interval = ", 
                                    interval[mean == max_mean])
        ),
        col = "red"
        )
dev.off()

## 3. Imputing missing values

activity_filled <- activity
for (i in 1:dim(activity)[1]){
        if (is.na(activity$steps[i])){
                activity_filled$steps[i] <- avg_daily$mean[activity_filled$interval[i] == avg_daily$interval]
        }
}

steps_sum_imputed <- with(activity_filled, 
                          aggregate(steps,
                                    by = list(date),
                                    FUN = sum))

png("plot3.png")
hist(steps_sum_imputed$x,
     main = "Total Number of Steps Taken per Day",
     xlab = "Number of Steps",
     breaks = seq(0,25000, by=2500),
     col = "darkgreen")
rug(steps_sum_imputed$x)
dev.off()

## 4. Are there differences in activity patterns between weekdays and weekends?

activity$daytype <- sapply(activity$weekday,
                           function(d) {
                                   if ((d == "Sathurday") || (d == "Sunday")){
                                           w <- "Weekend"
                                   } else {
                                           w <- "Weekday"
                                   }
                                   return(w)
                           })

activity_by_daytype <- aggregate(steps ~ interval + daytype, #+ daytype
                                 data = activity,
                                 FUN = mean,
                                 na.rm = T)

png("plot4.png")
ggplot(activity_by_daytype,
       aes(x = interval,
           y = steps,
           color = daytype)) +
        geom_line(size = 1) +
        facet_wrap(.~daytype,
                   ncol = 1,
                   nrow = 2) +
        labs(title = "Average Number of Steps per Interval comparing Weekday and Weekends",
             x = "Interval (min)",
             y = "Number of steps") +
        theme(legend.position = "none")
dev.off()