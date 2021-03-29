# 0. Getting data from web

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("rawData.zip")) download.file(fileURL, destfile = "rawData.zip")

unzip("rawData.zip")

# if package not installed
if(!require(dplyr)) install.packages("dplyr")
if(!require(reshape2)) install.packages("dplyr")

library(dplyr)
library(reshape2)

# 1. Merge the training and hte test set

## Reading train set
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
sub_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## Reading test sets
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
sub_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

## merging train and test
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(sub_train, sub_test)
colnames(subject) <- "sub_id"

## free memory
rm(list = c("x_train", "x_test", "y_train", "y_test", "sub_train", "sub_test"))

# 2. Use descriptive activity names
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
feature <- read.table("./UCI HAR Dataset/features.txt")

# 4. Appropriately label the data set

colnames(x) <- feature$V2

## add activity names for y
y <- left_join(y, activity, by = "V1")
colnames(y) <- c("act_id", "activity")

# 3. Extract only the mean and standard deviation (std)

selectedFeatures <- feature %>%
     select(V2) %>%
     sapply(function(x){grep(x = x, pattern = "-(mean|std).*")})

x.filtered <- x[,selectedFeatures]

tidydataset <- cbind(subject, y, x.filtered)
write.table(tidydataset, file = "tidydataset.txt", row.names = F)

## free space
rm(list = "fileURL", "x", "x.filtered", "y", "subject", "activity", "feature", "selectedFeatures")

# 5. Tidy data set with average of each variable for each activity and subject

avgData <- tidydataset %>%
     melt(id = c("sub_id", "activity")) %>%
     dcast(sub_id + activity ~ variable, mean)
write.table(avgData, file = "avgData.txt", row.names = F)
