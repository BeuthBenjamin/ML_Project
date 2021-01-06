# use t-SNE for dimension reduction of the contraceptive method choice data set
library(tsne)
library(caret)
library(data.table)
library(plyr)

# load the dataset with improved names
setwd('/home/benjamin/WS20_21/machine_learning_2/ML_Project/')
data <- as.data.table(read.csv(
  "cmc_mod.data",
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
data$WifeReligion <-
  revalue(data$WifeReligion, c("1" = "Islam", "0" = "Non-Islam"))
data$WifeWorking <-
  revalue(data$WifeWorking, c("1" = "No", "0" = "Yes"))
data$MediaExposure <-
  revalue(data$MediaExposure, c("1" = "Not good", "0" = "Good"))
data$ContraceptiveMethodUsed <-
  revalue(data$ContraceptiveMethodUsed,
          c("1" = "No-use", "2" = "Long-term", "3" = "Short-term"))

# we must not include the target variable for the tSNE algorithm
data_wo_cmc <- subset(data, select = -c(10))

# define ground truth as colors for the final plot
colors <- as.numeric(data$ContraceptiveMethodUsed)

# one hot encoding for categorical variables
dmy <- dummyVars(" ~ .", data = data_wo_cmc)
data_ohe <- data.frame(predict(dmy, newdata = data_wo_cmc))
print(data_ohe)

# fit tSNE
cmc.tsne <- tsne(data_ohe,
                 max_iter = 500,
                 epoch = 25,
                 perplexity = 10)

plot(cmc.tsne, col = colors)