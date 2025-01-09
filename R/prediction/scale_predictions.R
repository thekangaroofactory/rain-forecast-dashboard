

scale_predictions <- function(predictions, threshold = 0.5){

  # -- init column
  # raw_prediction may be NA in rare occasion
  predictions$scaled_prediction <- NA
  
  # -- for raw prediction in range [0, threshold]
  predictions[!is.na(predictions$raw_prediction) & predictions$raw_prediction <= threshold, ]$scaled_prediction <- predictions[!is.na(predictions$raw_prediction) & predictions$raw_prediction <= threshold, ]$raw_prediction * 0.5 / threshold
  
  # -- for raw prediction in range ]threshold, 1]
  predictions[!is.na(predictions$raw_prediction) & predictions$raw_prediction > threshold, ]$scaled_prediction <- (predictions[!is.na(predictions$raw_prediction) & predictions$raw_prediction > threshold, ]$raw_prediction - threshold) * 0.5 / (1 - threshold) + 0.5
  
  # -- return
  predictions
  
}
