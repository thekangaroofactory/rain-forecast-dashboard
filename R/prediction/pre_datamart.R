
pre_datamart <- function(predictions, observations){

  # -- cast date & reorder
  predictions$date <- as.Date(predictions$date)
  predictions <- predictions[order(predictions$date), ]
  
  # -- 
  predictions$expect_rain_tomorrow <- predictions$raw_prediction >= 0.28
  predictions$real_rain_tomorrow <- observations[match(predictions$date, observations$date), ]$rain_tomorrow
  predictions$accurate <- predictions$expect_rain_tomorrow == predictions$real_rain_tomorrow
  
  predictions$cumsum <- cumsum(ifelse(is.na(predictions$accurate), 0, predictions$accurate))
  predictions$count <- cumsum(ifelse(predictions$real_rain_tomorrow %in% c(TRUE, FALSE), TRUE, FALSE))
  
  predictions$cum_accuracy <- predictions$cumsum / predictions$count
  
  # -- return
  predictions
  
}
