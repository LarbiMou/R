## Cluster Analysis
### Larbi Moukhlis 

### Load Packages 

library(readr)
library(fastDummies)
library(C50)
library(rpart)

### Read CSV 

Data <- read.csv("HW_3_dataset.csv", header = TRUE)

### View structure of data, and notice if there are any NA or Missing Values

str(Data)

### Convert all categorical variables into dummy variables. 

df_dummies <- dummy_cols(Data, remove_first_dummy = FALSE, remove_selected_columns = TRUE)

### Remove Dummies Sex_NA column so it isn't used as a predictor in C5.0 (Normalize Data)

df_dummies$sex_NA <- NULL

### C5.0 Model to Clean Null Values

# Clean Null Values in columns using decision tree (C5.0)

# Identify rows with and without missing values
gender_original <- ifelse(df_dummies$sex_male == 1, "male",
                          ifelse(df_dummies$sex_female == 1, "female", NA))


# Training Data
train_rows   <- !is.na(gender_original)
missing_rows <-  is.na(gender_original)


# Remove the target dummy columns from predictors
predictor_cols <- setdiff(colnames(df_dummies), c("sex_male", "sex_female"))


### Train C5.0 model
# C5.0 structure ~ C5.0(x = predictors, y = Target, trials = 1)
model <- C5.0(x = df_dummies[train_rows, predictor_cols],y = factor(gender_original[train_rows]))

# Predict Missing Category
preds <- predict(model, df_dummies[missing_rows, predictor_cols])

### Step 5 — Fill predictions into internal gender vector
gender_original[missing_rows] <- preds

### Step 6 — Recreate BOTH dummy variables based on predictions
df_dummies$sex_male   <- ifelse(gender_original == "male", 1, 0)
df_dummies$sex_female <- ifelse(gender_original == "female", 1, 0)

### Step 7 

### Run K-Means
# normalization function for scaling
normalize <- function(x) {(x - min(x)) / (max(x) - min(x))}

# Apply to copy of dummies
df_norm <- as.data.frame(lapply(df_dummies, normalize))

# Run K-means
set.seed(123)
kmeans_model <- kmeans(df_norm, centers = 3, nstart = 25)

# Append cluster labels to original df_norm
Data$Cluster <- kmeans_model$cluster

# View Cluster Assignments
table(kmeans_model$cluster)

# Write CSV 
write.csv(Data, "HW_Dataset_Cleaned_with_clusters.csv", row.names = FALSE)


