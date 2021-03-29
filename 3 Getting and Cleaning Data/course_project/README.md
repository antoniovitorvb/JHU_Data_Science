<img src="https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://coursera-university-assets.s3.amazonaws.com/74/7ae340ec6911e5b395490a2a565172/JHU-Logo-Square-Mini_180px.png?auto=format%2Ccompress&dpr=1&w=56px&h=56px&auto=format%2Ccompress&dpr=1&w=&h=">

# [Getting and Cleaning Data Course Project](https://www.coursera.org/learn/data-cleaning?specialization=jhu-data-science)

### Author: Antonio Vitor Villas Boas
___
In this course project, a link to *zip file* was given.
The goal was to extract the text files inside the zip and transform them into a tidy data set.

The text files were imported to RStudio environment as data frames.

* Libraries used:
  * dplyr
  * reshape2

1. Download and unzip files
   
2. Load to independent data frames
   
3. Merge train and test sets.

    X, y and subject appears in separated text files. To tidy the whole data the train and test rows were binded.

4. Label the data set

    - The variables/columns of X relates to the features in *features.txt* so the X columns were named after them.
    - y describes the activity performed during the experiment. the activity labels are found in *activity_labes.txt*
    - The subject data frame relates to the user doing the exercise

5. Filter the features

    - Many features were measured uring the experiment, but only the means [mean()] and standart deviations [std()] were needed to tidy the data.
    - To filter the columns I used the grep() and sapply() functions to search for any "mean" OR "std" patterns.
    - With these functions applied I stored the result in *x.filtered*

6. Build the data set

    The tidy data set is a column bind [cbind()] of the subject, y and x.filtered data frames.

7. Tidy data set with average of each variable for each activity and subject

    - The 1st tidy data set was melted [melt()] with id's of subject and activity labels.
    - With the melted data I chained the dcast function where applied the mean function to each variable grouped by subject and activity label 