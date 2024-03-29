#load in the libraries
library(dplyr)
library(data.table)
library(Metrics)

#read in the interim files and any other necessary files
newtrain <- fread("./Coin_Project/volume/data/interim/newtrain.csv")
newtest <- fread("./Coin_Project/volume/data/interim/newtest.csv")
test <- fread("./Coin_Project/volume/data/raw/test_file.csv")

#create and save the model
glm_model<-glm(result~.,family=binomial,data=newtrain)
saveRDS(glm_model, "./Coin_Project/volume/models/glm_model")

#evaulate the model
summary(glm_model)
coef(glm_model)

#use the model to predict values
newtest$pred<-predict(glm_model,newdata = newtest,type="response")

id <- test$id
submit <- data.table(id)
submit$result <- newtest$pred
fwrite(submit, "./Coin_Project/volume/data/processed/submit.csv")
