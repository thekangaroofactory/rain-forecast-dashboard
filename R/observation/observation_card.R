

observation_card <- function(observation){
  
  card(
    
    card_header(observation$date),
    
    card_body(
      style = "font-size: 9pt",
      "Min temp.", ifelse(!is.na(observation$min_temp), paste0(observation$min_temp, "°C"), "-"), br(),
      "Max temps.", ifelse(!is.na(observation$max_temp), paste0(observation$max_temp, "°C"), "-"), br(),
      "Rainfall", ifelse(!is.na(observation$rain_fall), paste0(observation$rain_fall, "mm"), "-"), br(),
      "Sunshine", ifelse(!is.na(observation$sunshine), paste0(observation$sunshine, "h"), "-"), br())
    
  )  
  
}
