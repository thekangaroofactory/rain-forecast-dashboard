

prediction_card <- function(prediction){
  
  # -- compute confusion status
  c_mat <- confusion_matrix(prediction) == 1
  c_status <- colnames(c_mat)[which(c_mat == TRUE, arr.ind = TRUE)[,2]]
  
  # -- build & return ui
  card(
    
    card_header(prediction$date_tomorrow),
    
    card_body(
      style = "font-size: 9pt",
      "Predict rain: ", prediction$expect_rain_tomorrow, br(),
      
      if(prediction$date_tomorrow <= Sys.Date()){
        p("Real rain: ", prediction$real_rain_tomorrow, br(),
        "Real rainfall:", paste0(prediction$real_rain_fall_tomorrow, "mm"), br(), br(),
        "Status:", ifelse(prediction$expect_rain_tomorrow == prediction$real_rain_tomorrow, "accurate", "inaccurate"), br(),
        "Detail:", c_status)}
      
      ))
  
}
