

observation_card <- function(observation){
  
  card(
    
    card_header(observation$date),
    
    card_body(
      style = "font-size: 9pt",
      "Min temp.", paste0(observation$min_temp, "°C"), br(),
      "Max temps.", paste0(observation$max_temp, "°C"), br(),
      "Rainfall", paste0(observation$rain_fall, "mm"), br(),
      "Sunshine", paste0(observation$sunshine, "h"), br())
    
  )  
  
}
