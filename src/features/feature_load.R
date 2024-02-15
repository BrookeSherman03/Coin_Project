#libraries to use
library(dplyr)
library(data.table)
library(Metrics)

#load data
#train <- fread("./Coin_Project/volume/data/raw/train_file.csv")
#test <- fread("./Coin_Project/volume/data/raw/test_file.csv")
train <- fread("C:/Users/Groot/OneDrive - The Pennsylvania State University/Documents/Coin_Project/volume/data/raw/train_file.csv")
test <- fread("C:/Users/Groot/OneDrive - The Pennsylvania State University/Documents/Coin_Project/volume/data/raw/test_file.csv")

id <- test$id
train_result <- train$result

newtrain <- subset(train, select = -c(id, result))
newtest <- subset(test, select = -c(id))

newtrain <- data.table(rowSums(newtrain))
newtest <- data.table(rowSums(newtest))

newtrain$result <- train_result

glm_model<-glm(result~.,family=binomial,data=newtrain)
saveRDS(glm_model, "C:/Users/Groot/OneDrive - The Pennsylvania State University/Documents/Coin_Project/volume/models/glm_model")

summary(glm_model)
coef(glm_model)

test$pred<-predict(glm_model,newdata = newtest,type="response")

submit <- data.table(id)
submit$result <- test$pred
fwrite(submit, "C:/Users/Groot/OneDrive - The Pennsylvania State University/Documents/Coin_Project/volume/data/processed/submit.csv")
