#libraries to use
library(dplyr)
library(data.table)
library(Metrics)

#load data
train <- fread("C:/Users/Groot/OneDrive - The Pennsylvania State University/Documents/Coin_Project/volume/data/raw/train_file.csv")
test <- fread("C:/Users/Groot/OneDrive - The Pennsylvania State University/Documents/Coin_Project/volume/data/raw/test_file.csv")

#will be needed for the model
train_result <- train$result

#drop columns not needed for rowSum
newtrain <- subset(train, select = -c(id, result))
newtest <- subset(test, select = -c(id))

#utilize rowSum
newtrain <- data.table(rowSums(newtrain))
newtest <- data.table(rowSums(newtest))

#keep the result to test the model
newtrain$result <- train_result

#write to interim to be used for model
fwrite(newtrain, "C:/Users/Groot/OneDrive - The Pennsylvania State University/Documents/Coin_Project/volume/data/interim/newtrain.csv")
fwrite(newtest, "C:/Users/Groot/OneDrive - The Pennsylvania State University/Documents/Coin_Project/volume/data/interim/newtest.csv")
