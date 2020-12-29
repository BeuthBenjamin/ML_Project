library(data.table)
library(tree)
library(plyr)

# Override cv.tree function so that we can use custom validation data set
cv.tree <- function (object,
                     rand,
                     FUN = prune.tree,
                     K = 10,
                     validationdata = NULL,
                     ...) {
  if (!inherits(object, "tree"))
    stop("not legitimate tree")
  m <- model.frame(object)
  extras <- match.call(expand.dots = FALSE)$...
  FUN <- deparse(substitute(FUN))
  init <- do.call(FUN, c(list(object), extras))
  if (missing(rand))
    rand <- sample(K, length(m[[1L]]), replace = TRUE)
  cvdev <- 0
  extras$k <- NULL
  for (i in unique(rand)) {
    if(missing(validationdata))
      newdata <- m[rand == i, , drop = FALSE]
    else
      newdata <- validationdata
    tlearn <- tree(model = m[rand != i, , drop = FALSE])
    plearn <- do.call(FUN, c(list(
      tlearn, newdata = newdata, k = init$k
    ), extras))
    cvdev <- cvdev + plearn$dev
  }
  init$dev <- cvdev
  init
}

# Read data ####

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
data$WifeReligion <- revalue(data$WifeReligion, c("1" = "Islam", "0" = "Non-Islam"))
data$WifeWorking <- revalue(data$WifeWorking, c("1" = "No", "0" = "Yes"))
data$MediaExposure <- revalue(data$MediaExposure, c("1" = "Not good", "0" = "Good"))
data$ContraceptiveMethodUsed <- revalue(data$ContraceptiveMethodUsed,
                                        c("1" = "No-use", "2" = "Long-term", "3" = "Short-term"))

# Split data ####

set.seed(2021)
n <- nrow(data)
train.split <- sample(1:n, n * 0.6)
validation.split <- sample((1:n)[-train.split], n * 0.2)
test.split <- (1:n)[-c(train.split, validation.split)]

train <- data[train.split]
validation <- data[validation.split]
test <- data[test.split]

# Train model ####

tree.data <- tree(ContraceptiveMethodUsed ~ .,
                  train,
                  mindev = 0,
                  minsize = 2)

# Validate model ####

cv.data <- cv.tree(tree.data, validationdata = validation, method = "misclass")
best <- cv.data$size[max(which(cv.data$dev == min(cv.data$dev)))]
pruned <- prune.misclass(tree.data, best = best)

# Test model ####

summary(pruned)
plot(pruned)
text(pruned, pretty = 0)

result <- table(
  "predicted" = predict(tree.data, test, type = "class"),
  "test" = test$ContraceptiveMethodUsed
)
accuracy <- sum(diag(result))/nrow(test)
print(accuracy)
