library(e1071)
library(caret)

# import data
source("Data/import.R")

# train a default SVM
svm_model <-
  svm(
    formula = ContraceptiveMethodUsed ~ .,
    data = train,
    kernel = "polynomial",
    cost = 1,
    degree = 3
  )

summary(svm_model)

pred <- fitted(svm_model)

# test model with validation data
x_val <- subset(validation, select = -ContraceptiveMethodUsed)
y_val <- validation$ContraceptiveMethodUsed
print(confusionMatrix(predict(svm_model, x_val), y_val))
