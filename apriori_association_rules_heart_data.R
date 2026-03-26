### ---
###  title: Apriori Heart Data"
### author: "Larbi"
### output: html_document
### ---

# R Setup 
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "/Users/larbimoukhlis/Library/CloudStorage/OneDrive-LoyolaUniversityChicago/INFS 348/HW 1/hdata")

# Set working directory
setwd("~/Library/CloudStorage/OneDrive-LoyolaUniversityChicago/INFS 348/HW 1/hdata")

# Install and load arules and rtools
install.packages("rtools")
install.packages("arules")
# install.packages("arules") and ("rtools")
library("arules")
library("rtools")

# Read data
heartdata <- read.table("hdata_categorical.txt", header = TRUE, sep = "|", stringsAsFactors = TRUE)

# Convert to transactions
htrans <- as(heartdata, "transactions")

# Generate association rules
hrules <- apriori(htrans, parameter = list(support = 0.1, confidence = 0.9, minlen = 2))

# Subset rules by class
hrules.buff <- subset(hrules, subset = rhs %oin% "class=buff")
hrules.sick <- subset(hrules, subset = rhs %oin% "class=sick")

# Convert to data frames
hrules_buff_df <- as(hrules.buff, "data.frame")
hrules_sick_df <- as(hrules.sick, "data.frame")

# Write results to files
write.table(hrules_buff_df, file = "hrulebuff.txt", sep = "|", quote = FALSE, row.names = FALSE)
write.table(hrules_sick_df, file = "hrulesick.txt", sep = "|", quote = FALSE, row.names = FALSE)


# Combine and get top 5 rules by confidence and support
all_rules <- rbind(hrules_buff_df, hrules_sick_df)
top5_all <- head(all_rules[order(-all_rules$confidence, -all_rules$support), ], 5)
top5_all
