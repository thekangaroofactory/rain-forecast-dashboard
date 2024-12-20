
pre_datamart <- function(predictions, observations){

  # -- cast date & reorder
  # keep increasing order otherwise count & stats will be in reverse order
  predictions$date <- as.Date(predictions$date)
  predictions <- predictions[order(predictions$date), ]
  
  # -- add columns
  predictions$date_tomorrow <- predictions$date + 1
  predictions$real_rain_fall_tomorrow <- observations[match(predictions$date_tomorrow, observations$date), ]$rain_fall
  
  # -- compute binary prediction & check
  predictions$expect_rain_tomorrow <- predictions$raw_prediction >= 0.28
  predictions$real_rain_tomorrow <- observations[match(predictions$date, observations$date), ]$rain_tomorrow
  predictions$accurate <- predictions$expect_rain_tomorrow == predictions$real_rain_tomorrow
  
  # -- compute cumulative stats
  predictions$cumsum <- cumsum(ifelse(is.na(predictions$accurate), 0, predictions$accurate))
  predictions$count <- cumsum(ifelse(predictions$real_rain_tomorrow %in% c(TRUE, FALSE), TRUE, FALSE))
  predictions$cum_accuracy <- predictions$cumsum / predictions$count
  
  # -- return
  predictions
  
}
