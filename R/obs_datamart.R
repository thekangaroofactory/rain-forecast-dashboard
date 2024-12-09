

obs_datamart <- function(observations){
  
  # -- cast date & reoder
  observations$date <- as.Date(observations$date)
  observations <- observations[order(observations$date, decreasing = T), ]
  
  # -- extract month
  observations$month <- factor(format(observations$date, "%m"),
                       levels = c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"))
  
  # -- add columns
  observations$rain_today <- observations$rain_fall > 0
  observations$rain_tomorrow <- observations[match(observations$date + 1, observations$date), ]$rain_today
  
  # -- return
  observations
  
}
