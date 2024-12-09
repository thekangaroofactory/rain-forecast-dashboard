

compute_seasons <- function(observations){
  
  # -- get years from df
  years <- as.numeric(unique(format(observations$date, "%Y")))
  years <- c(years, max(years) + 1)
  
  # -- compute summers
  summer <- data.frame(name = "summer",
                       start = as.Date(paste(years - 1, "12-01", sep = "-")),
                       end = as.Date(paste(years, "02-28", sep = "-")))
  
  # -- compute winters
  winter <- data.frame(name = "winter",
                       start = as.Date(paste(years, "06-01", sep = "-")),
                       end = as.Date(paste(years, "08-31", sep = "-")))
  
  # -- merge
  seasons <- rbind(winter, summer)
  
  # -- fix start / end
  seasons <- seasons[order(seasons$start), ]
  seasons <- seasons[seasons$start >= min(observations$date), ]
  seasons <- seasons[seasons$start <= max(observations$date), ]
  seasons[seasons$end > max(observations$date), ]$end <- max(observations$date)
  
  # -- return
  seasons
  
}
