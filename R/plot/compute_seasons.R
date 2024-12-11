

compute_seasons <- function(observations){

  # -- get years & extend range by 1 (on each side)
  years <- as.numeric(unique(format(observations$date, "%Y")))
  years <- sort(c(min(years) - 1, years, max(years) + 1))
  
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
  
  # -- filter out seasons not overlapping with data
  seasons <- seasons[order(seasons$start), ]
  seasons <- seasons[seasons$end >= min(observations$date), ]
  seasons <- seasons[seasons$start <= max(observations$date), ]
  
  # -- fix start / end dates
  if(any(seasons$start < min(observations$date)))
    seasons[1, 'start'] <- min(observations$date)
  if(any(seasons$end > max(observations$date)))
    seasons[nrow(seasons), 'end'] <- max(observations$date)
  
  # -- return
  seasons
  
}
