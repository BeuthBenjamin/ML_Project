library(data.table)
library(plyr)

# load the dataset with improved names
data <- as.data.table(read.csv(
  "Data/cmc_mod.data",
  colClasses = c(
    "integer",
    "factor",
    "factor",
    "integer",
    "factor",
    "factor",
    "factor",
    "factor",
    "factor",
    "factor"
  )
))
data$WifeReligion <- revalue(data$WifeReligion, c("1" = "Islam", "0" = "Non-Islam"))
data$WifeWorking <- revalue(data$WifeWorking, c("1" = "No", "0" = "Yes"))
data$MediaExposure <- revalue(data$MediaExposure, c("1" = "Not good", "0" = "Good"))
data$ContraceptiveMethodUsed <- revalue(data$ContraceptiveMethodUsed,
                                        c("1" = "No-use", "2" = "Long-term", "3" = "Short-term"))

# split the data

set.seed(2020)
n <- nrow(data)
train.split <- sample(1:n, n * 0.6)
validation.split <- sample((1:n)[-train.split], n * 0.2)
test.split <- (1:n)[-c(train.split, validation.split)]

train <- data[train.split]
validation <- data[validation.split]
test <- data[test.split]
train_and_validation <- data[-test.split]