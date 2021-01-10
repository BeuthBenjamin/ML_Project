library(e1071)

# import data
source("Data/import.R")

# train, validation, test split as required
set.seed(2021)
idx <-
  sample(
    seq(1, 3),
    size = nrow(data),
    replace = TRUE,
    prob = c(0.6, 0.2, 0.2)
  )
train <- data[idx == 1,]
validation <- data[idx == 2,]
test <- data[idx == 3,]

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

