library(caret)
library(dplyr)
library(rattle)

if (!file.exists("pml-training.csv") || !file.exists("pml-testing.csv")){
     
     trainURL <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
     testURL <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
     
     download.file(trainURL,
                   destfile = "pml-training.csv")
     download.file(testURL,
                   destfile = "pml-testing.csv")
}

train_set <- read.csv("pml-training.csv",
                      na.strings = c("", "#DIV/0!", "NA"))
test_set <- read.csv("pml-testing.csv",
                     na.strings = c("", "#DIV/0!", "NA"))

set.seed(123)

# Cleaning the data

training <- train_set[ , colMeans(is.na(train_set)) < 0.9] %>%
     select(-(X:num_window))

# Testing Models

inTrain  <- createDataPartition(train_set$classe,
                                p = 0.7,
                                list = FALSE)
training <- training[inTrain, ]
testing <- training[-inTrain, ]

control <- trainControl(method = "cv",
                        number = 3,
                        verboseIter = FALSE)

## Decision Tree

DT_model <- train(classe ~ ., 
                  data = training,
                  method = "rpart",
                  trControl = control,
                  tuneLength = 5)

fancyRpartPlot(DT_model$finalModel)

DT_pred <- predict(DT_model, testing)
DT_cm <- confusionMatrix(DT_pred, factor(testing$classe))

acc <- vector() # Vector with all models accuracy
acc["Decision Tree"] <- DT_cm$overall[1]

## Random Forest

RF_model <- train(classe ~ ., 
                  data = training,
                  method = "rf",
                  trControl = control,
                  tuneLength = 5)

RF_pred <- predict(RF_model, testing)
RF_cm <- confusionMatrix(RF_pred, factor(testing$classe))

acc["Random Forest"] <- RF_cm$overall[1]

## Gradient Boosted Trees

GBT_model <- train(classe ~ ., 
                  data = training,
                  method = "gbm",
                  trControl = control,
                  tuneLength = 5,
                  verbose = FALSE)

GBT_pred <- predict(GBT_model, testing)
GBT_cm <- confusionMatrix(GBT_pred, factor(testing$classe))

acc["Grad Boosted"] <- GBT_cm$overall[1]

# Support Vector Machine

SVM_model <- train(classe ~ ., 
                   data = training,
                   method = "svmLinear",
                   trControl = control,
                   tuneLength = 5,
                   verbose = FALSE)

SVM_pred <- predict(SVM_model, testing)
SVM_cm <- confusionMatrix(SVM_pred, factor(testing$classe))

acc["SVM"] <- SVM_cm$overall[1]

acc

# Random Forest performed better