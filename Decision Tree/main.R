library(data.table)
library(tree)
library(plyr)

# Override cv.tree function so that we can use custom validation data set
# cv.tree <- function (object,
#                      rand,
#                      FUN = prune.tree,
#                      K = 10,
#                      validationdata = NULL,
#                      ...) {
#   if (!inherits(object, "tree"))
#     stop("not legitimate tree")
#   m <- model.frame(object)
#   extras <- match.call(expand.dots = FALSE)$...
#   FUN <- deparse(substitute(FUN))
#   init <- do.call(FUN, c(list(object), extras))
#   if (missing(rand))
#     rand <- sample(K, length(m[[1L]]), replace = TRUE)
#   cvdev <- 0
#   extras$k <- NULL
#   for (i in unique(rand)) {
#     if(missing(validationdata))
#       newdata <- m[rand == i, , drop = FALSE]
#     else
#       newdata <- validationdata
#     tlearn <- tree(model = m[rand != i, , drop = FALSE])
#     plearn <- do.call(FUN, c(list(
#       tlearn, newdata = newdata, k = init$k
#     ), extras))
#     cvdev <- cvdev + plearn$dev
#   }
#   init$dev <- cvdev
#   init
# }

# Read & Split Data ####

source("Data/import.R")

train_model <- function(data, minsize) {
  # Train model ####
  tree.data <- tree(ContraceptiveMethodUsed ~ .,
                    data,
                    mindev = 0,
                    minsize = minsize)

  # Prune Model ####
  cv.data <- cv.tree(tree.data, method = "misclass")
  best <- cv.data$size[max(which(cv.data$dev == min(cv.data$dev)))]
  pruned <- prune.misclass(tree.data, best = best)
  return(pruned)
}

calculate_accuracy <- function(model, data){
  result <- table(
    "predicted" = predict(model, data, type = "class"),
    "test" = data$ContraceptiveMethodUsed
  )
  return(list(sum(diag(result))/nrow(test), result))
}

# Find best minsize
vals <- 1:25
for (i in vals){
  pruned <- train_model(train, i)
  vals[i] <- calculate_accuracy(pruned, validation)[1]
}
best <- which.max(vals)
print(paste("Best minsize for Tree:",best))

# train our final model with both validation and training data
final_tree_model <- train_model(train_and_validation, best)
print(summary(final_tree_model))
plot(final_tree_model)
text(final_tree_model)

# Test model ####
print("Test Data Result")
print(calculate_accuracy(final_tree_model, test))

confusionMatrix(
  predict(final_tree_model, subset(test, select = -ContraceptiveMethodUsed), type='class'),
  test$ContraceptiveMethodUsed
)
