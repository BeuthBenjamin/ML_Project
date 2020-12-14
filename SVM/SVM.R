# load the dataset with improved names
setwd('/home/benjamin/WS20_21/machine_learning_2/ML_Project/')
df <- read.csv('cmc_mod.data')

# convert variables to factor variables
cols <- c(
  "WifeEducation",
  "HusbandEducation",
  "WifeReligion",
  "WifeWorking",
  "HusbandOccupation",
  "StandardOfLivingIndex",
  "MediaExposure",
  "ContraceptiveMethodUsed"
)
df[cols] <- lapply(df[cols], as.factor)
sapply(df, class)

# train, validation, test split as required
set.seed(2021)
idx <-
  sample(
    seq(1, 3),
    size = nrow(df),
    replace = TRUE,
    prob = c(0.6, 0.2, 0.2)
  )
train <- df[idx == 1,]
validation <- df[idx == 2,]
test <- df[idx == 3,]

# train a SVM
cost_param = 10
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
