

compute_seasons <- function(observations){
  
  years <- as.numeric(unique(format(observations$date, "%Y")))
  years <- c(years, max(years) + 1)
  
  summer <- data.frame(name = "summer",
                       start = as.Date(paste(years - 1, "12-01", sep = "-")),
                       end = as.Date(paste(years, "02-28", sep = "-")))
  
  winter <- data.frame(name = "winter",
                       start = as.Date(paste(years, "06-01", sep = "-")),
                       end = as.Date(paste(years, "08-31", sep = "-")))
  
  seasons <- rbind(winter, summer)
  
  seasons <- seasons[order(seasons$start), ]
  seasons <- seasons[seasons$start >= min(observations$date), ]
  seasons <- seasons[seasons$start <= Sys.Date(), ]
  seasons[seasons$end > Sys.Date(), ]$end <- Sys.Date()
  
  # -- return
  seasons
  
}
