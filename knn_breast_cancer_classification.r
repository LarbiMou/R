# from "Data Mining INFS348 Spring 2023" 
# "#" sign means these lines are comments/documentation and not 
# the codes that need execution. 
#############################################################
## Step 1:

## set your working directory- we have done it million times already. 
setwd("your working directory/LAB05")
## Data about teens is in student table on the database. So lets log into the database and see the structure. 
# import the CSV file
wbcd <- read.csv("wisc_bc_data.csv")

# examine the structure of the wbcd data frame
str(wbcd)

# drop the id feature
wbcd <- wbcd[-1]

wbcd$diagnosis = as.factor(wbcd$diagnosis)

# table of diagnosis
table(wbcd$diagnosis)


# normalize the wbcd data
wbcd_n <- as.data.frame(lapply(wbcd[3:31], scale))

# confirm that normalization worked
summary(wbcd_n$area_mean)

# create training and test data
wbcd_train <- wbcd_n[1:469, ]
wbcd_test <- wbcd_n[470:569, ]

# create labels for training and test data

wbcd_train_labels <- wbcd[1:469, 1]
wbcd_test_labels <- wbcd[470:569, 1]

## Step 3: Training a model on the data ----

# load the "class" library
library(class)

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,
                      cl = wbcd_train_labels, k = 21)

## Step 4: Evaluating model performance ----

table(wbcd_test_labels,  wbcd_test_pred)