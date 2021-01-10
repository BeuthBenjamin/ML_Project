source('SVM/SVM.R')

# all options
costs <- 10^(0:3)
gammas <- c(0, 1/18, 10^(-3:-1)) # 1/18 is the gamma default value, 1/dimensions of the data
degrees <- 2:5
coef0s <- c(0, 10^-3:3)

add_kernel <- function(obj, kernel_name){
  obj['kernel'] <- kernel_name
  return(obj)
}

log <- function(tuned){
  cat("\n##############\n\nBest model for ", tuned$kernel, ":\n\n##############\n\nParameters:\n")
  print(tuned$best.parameters)
  print(confusionMatrix(predict(tuned$best.model, x_val), y_val))
  return(tuned)
}
# Tune each kernel
lin_tuned <- log(add_kernel(tune.svm(ContraceptiveMethodUsed~., data = train,
                          cost = costs,
                          kernel = "linear",
                          validation.x = x_val, validation.y = y_val,
                          tunecontrol = tune.control(sampling = "fix")
), "linear"))

rad_tuned <- log(add_kernel(tune.svm(ContraceptiveMethodUsed~., data = train,
                          cost = costs,
                          gamma = gammas,
                          kernel = "radial",
                          validation.x = x_val, validation.y = y_val,
                          tunecontrol = tune.control(sampling = "fix")
), "radial"))

poly_tuned <- log(add_kernel(tune.svm(ContraceptiveMethodUsed~., data = train,
                           cost = costs,
                           gamma = gammas,
                           degree = degrees,
                           coef0 = coef0s,
                           kernel = "polynomial",
                           validation.x = x_val, validation.y = y_val,
                           tunecontrol = tune.control(sampling = "fix")
), "polynomial"))

sig_tuned <- log(add_kernel(tune.svm(ContraceptiveMethodUsed~., data = train,
                           cost = costs,
                           gamma = gammas,
                           coef0 = coef0s,
                           kernel = "sigmoid",
                           validation.x = x_val, validation.y = y_val,
                           tunecontrol = tune.control(sampling = "fix")
), "sigmoid"))

# Find the best model
all_models <- list(lin_tuned, rad_tuned, poly_tuned, sig_tuned)
Best.performances <- lapply(all_models, function(x) x[["best.performance"]])
best_model <- all_models[which.min(Best.performances)][[1]]

# train our final model with both validation and training data
final_svm_model <- do.call(svm, c(
  formula = ContraceptiveMethodUsed ~ .,
  data = list(train_and_validation),
  kernel = best_model$kernel,
  best_model$best.parameters
)
)

# Apply the model to the test set
confusionMatrix(
  predict(final_svm_model, subset(test, select = -ContraceptiveMethodUsed)),
  test$ContraceptiveMethodUsed
)
