library(e1071)
library(caret)

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

# train a default SVM
svm_model <-
  svm(
    ContraceptiveMethodUsed ~ .,
    data = train,
    scale = TRUE,
    kernel = "polynomial",
    cost = 10,
    degree = 3,
  )

summary(svm_model)

pred <- fitted(svm_model)

# test model with validation data
x_val <- subset(validation, select = -ContraceptiveMethodUsed)
y_val <- validation$ContraceptiveMethodUsed
print(confusionMatrix(predict(svm_model, x_val), y_val))
