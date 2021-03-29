<img src="https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://coursera-university-assets.s3.amazonaws.com/74/7ae340ec6911e5b395490a2a565172/JHU-Logo-Square-Mini_180px.png?auto=format%2Ccompress&dpr=1&w=56px&h=56px&auto=format%2Ccompress&dpr=1&w=&h=">

# [Getting and Cleaning Data Course Project](https://www.coursera.org/learn/data-cleaning?specialization=jhu-data-science)

## Codebook
### Author: Antonio Vitor Villas Boas
___

### UCI HAR Dataset [rows x cols]

The files used in the analysis were:
- **activity_labels.txt [6x2]:** has the name of each activity and its respective id number
- **features.txt [561x2]:** describes the name of each feature the experiment measured
- **/test/subject_test.txt [2947x1]:** is the ID of each subject used to test the experiment
- **/test/X_test.txt [2947x561]:** observations of each feature used to test the experiment
- **/test/y_test.txt [2947x1]:** which activity was performed used to test the experiment
- **/train/subject_train.txt [7352x1]:** is the ID of each subject used to train the experiment
- **/train/X_train.txt [7352x561]:** observations of each feature used to train the experiment
- **/train/y_train.txt [7352x1]:** which activity was performed used to train the experiment

### Merged data sets

- **x [10299x561]:** all observations of each feature of the experiment
- **y[10299x2]:** all activities perfomed during the experiment with its id number and name
- **subject [10299x1]:** id of all subjects of the test in each activity
- **activity [6x2]:** data frame with activity labels
- **feature [561x2]:** data frame with all features

### Tidy data set components

- **selectedFeatures [1x79]:** array with the index of all columns that contains "mean" or "std"
- **x.filtered [10299x79]:** all observations with only the mean or standart deviation feaures
- **tidydataset [10299x82]:** tidy data set and goal of this project
- **avgData [180x82]:** indepoendent tidy data set with the average of each variable for each activity and each subject.