source('SVM/SVM.R')

# all options
scales <- c(TRUE, FALSE)
costs <- 10^(1:3)
gammas <- 10^(-3:-1)
degrees <- 2:4

log <- function(tuned, kernel_name){
  cat("\n##############\n\nBest model for ", kernel_name, ":\n\n##############\n\nParameters:\n")
  print(tuned$best.parameters)
  print(confusionMatrix(predict(tuned$best.model, x_val), y_val))
  return(tuned)
}

lin_tuned <- log(tune.svm(ContraceptiveMethodUsed~., data = train,
                          scale = scales,
                          cost = costs,
                          kernel = "linear",
                          validation.x = x_val, validation.y = y_val,
                          tunecontrol = tune.control(sampling = "fix")
), "linear")

rad_tuned <- log(tune.svm(ContraceptiveMethodUsed~., data = train,
                          scale = scales,
                          cost = costs,
                          gamma = gammas,
                          kernel = "radial",
                          validation.x = x_val, validation.y = y_val,
                          tunecontrol = tune.control(sampling = "fix")
), "radial")

poly_tuned <- log(tune.svm(ContraceptiveMethodUsed~., data = train,
                           scale = scales,
                           cost = costs,
                           gamma = gammas,
                           degree = degrees,
                           kernel = "polynomial",
                           validation.x = x_val, validation.y = y_val,
                           tunecontrol = tune.control(sampling = "fix")
), "polynomial")
