# use t-SNE for dimension reduction of the contraceptive method choice Data set
library(tsne)
library(caret)

# load the dataset with improved names
source("Data/import.R")

# we must not include the target variable for the tSNE algorithm
data_wo_cmc <- subset(data, select = -c(10))

# define ground truth as colors for the final plot
colors <- as.numeric(data$ContraceptiveMethodUsed)

# one hot encoding for categorical variables
dmy <- dummyVars(" ~ .", data = data_wo_cmc)
data_ohe <- data.frame(predict(dmy, newdata = data_wo_cmc))
# print(data_ohe)

# fit tSNE
cmc.tsne <- tsne(data_ohe,
                 max_iter = 500,
                 epoch = 25,
                 perplexity = 10)

plot(cmc.tsne, col = colors)