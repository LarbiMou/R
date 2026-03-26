
### Set Working Directory
setwd("~/Library/CloudStorage/OneDrive-LoyolaUniversityChicago/INFS 348/HW 2")

### Read Data
hdata <- read.table("data.txt", header = TRUE, sep = "|")

### Examine the Structure of the Dataframe
str(hdata)

### Remove the last column of the dataframe because it is 100% correlated with column 14 (class) so we do not need both.
hdata = hdata[-15]

###Creates a table for the data, in this case there are 165 buff and 138 sick records
table(hdata$class)

### Use set.seed so I can repeat the script without getting a new random set every time
set.seed((123))

### This cuts a random sample of the data, nrow(hdata) returns the number of records in the df, we multiply it by .75 because we want a random sample of 75% of the data to create the training dataset 
train_sample <- sample(nrow(hdata), nrow(hdata)*0.75)

###This shows us the structure of the train_sample variable. This shows there are 227 random numbers.
str(train_sample)

### I used the train_sample variable to select rows in the hdata dataframe, to create our training dataset. This gives us 227 random rows and all columns from the hdata dataset.
hdata_train <- hdata[train_sample,]

### To create the testing dataset, I use a minus sign before the train_sample variable to give us all rows except the 227 random rows selected for the training dataset.
hdata_test <- hdata[-train_sample,]

### Check to see if there is a similar proportion of sick and buff records in the training dataset.
prop.table(table(hdata_train$class))
prop.table(table(hdata_test$class))

### Make sure that the training data class column is set as a factor so that C5.0 has a "factor outcome"
hdata_train$class <- as.factor(hdata_train$class)

### Load C.50
library("C50")

###C5.0 uses the first argument as predictor variables and second as target so we exclude the 14th column by using hdata_train[,-14] because it is the target, not a predictor
hdata_model <- C5.0(hdata_train[-14], hdata_train$class)

### Displays simple facts about the tree
hdata_model

###Shows a summary of the model
summary(hdata_model)

### Using the predict function, we input two arguments: first, the model I just created and second the test data frame. This creates a factor vector of predictions on test data.
hdata_pred <- predict(hdata_model, hdata_test)

### Table shows how many times the model made the right prediction 
table(hdata_test$class, hdata_pred)

### Boosting to improve the model. It needs an argument about how many trees we need to grow, In this case, 11 trees.
hdata_model_boosting <- C5.0(hdata_train[-14], hdata_train$class, trials=11)

### I trained the boosting model, so I test it using the prediction function as a regular decision tree.
hdata_pred <- predict(hdata_model_boosting, hdata_test)

### I create a table to see predicted vs. actual
table(hdata_test$class, hdata_pred)
