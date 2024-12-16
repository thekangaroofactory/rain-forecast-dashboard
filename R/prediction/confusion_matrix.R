

confusion_matrix <- function(predictions){

  # -- compute matrix & return
  predictions %>%
    summarise(true_positive = sum(expect_rain_tomorrow & real_rain_tomorrow, na.rm = T),
              false_positive = sum(expect_rain_tomorrow & !real_rain_tomorrow, na.rm = T),
              true_negative = sum(!expect_rain_tomorrow & !real_rain_tomorrow, na.rm = T),
              false_negative = sum(!expect_rain_tomorrow & real_rain_tomorrow, na.rm = T))
  
}
