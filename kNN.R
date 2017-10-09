training <- read.csv("data.csv", header = T , sep = "," , stringsAsFactors = F)
str(training)
training <- training[-1]
table(training$diagnosis)
training$diagnosis <- factor(training$diagnosis, levels = c("B","M"),  labels = c("Beneign", "Malignt"))
round(prop.table(table(training$diagnosis))*100, digits = 1)
summary(training[c("radius_mean", "area_mean", "smoothness_mean")])

normalize <- function (x){
  return ((x - min(x)) / (max(x) - min(x)))
}

normalize(c(10,20,30,40,50))
training_n <- as.data.frame(lapply(training[2:31], normalize))
summary(training_n[c("radius_mean", "area_mean", "smoothness_mean")])

model_train <- training_n[1:469,]
model_test <- training_n[470:569,]

model_train_labels <- training[1:469,1]
model_test_labels <- training[470:569,1]

library(class)
model_test_pred <- knn(train = model_train, test = model_test, cl= model_train_labels, k=21)

install.packages("gmodels")
library(gmodels)

CrossTable( x= model_test_labels, y= model_test_pred, prop.chisq = FALSE)

training_z <- as.data.frame(scale(training[2:31]))
summary(training_z$area_mean)

model_train <- training_z[1:469,]
model_test <- training_z[470:569,]

model_train_labels <- training[1:469,1]
model_test_labels <- training[470:569,1]

model_test_pred <- knn(train = model_train, test = model_test, cl=model_train_labels, k=8)

CrossTable( x= model_test_labels, y= model_test_pred, prop.chisq = FALSE)

?CrossTable

