library(e1071)

# import data
source("Data/import.R")

# train a SVM
cost_param <- 10
{
svm_model <-
  svm(
    ContraceptiveMethodUsed ~ .,
    data = train,
    scale = TRUE,
    kernel = "polynomial",
    cost = cost_param,
    degree = 3
  )
summary(svm_model)
pred <- fitted(svm_model)
pred

# test model with validation data
x_val <- subset(validation, select = -ContraceptiveMethodUsed)
y_val <- validation$ContraceptiveMethodUsed
pred_val <- predict(svm_model, x_val)
class_matrix <- table(pred_val, y_val)
acc <- sum(diag(class_matrix))/sum(class_matrix); acc
}

