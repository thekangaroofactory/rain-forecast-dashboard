

prediction_card <- function(prediction){
  
  # -- prepare value
  chance_of_rain <- round(prediction$scaled_prediction * 100)
  
  # -- compute confusion status
  c_mat <- confusion_matrix(prediction) == 1
  c_status <- colnames(c_mat)[which(c_mat == TRUE, arr.ind = TRUE)[,2]]
  
  # -- build & return ui
  card(
    
    card_header(prediction$date_tomorrow),
    
    card_body(
      style = "font-size: 9pt",
      
      # -- prediction
      "Predict rain: ", prediction$expect_rain_tomorrow, br(),
      "Chance of rain: ", paste0(chance_of_rain, "%"),
      
      # -- progress bar (chance of rain)
      div(class = "progress",
          style = "height: 10px;",
          div(class = paste("progress-bar progress-bar-striped", ifelse(chance_of_rain >= 50, "bg-cyan", "bg-secondary")),
              role = "progressbar",
              style = paste0("width: ", chance_of_rain, "%;"))),

      # -- prediction status
      if(prediction$date_tomorrow <= Sys.Date()){
        p("Real rain: ", prediction$real_rain_tomorrow, br(),
        "Real rainfall:", paste0(prediction$real_rain_fall_tomorrow, "mm"), br(), br(),
        "Status:", ifelse(prediction$expect_rain_tomorrow == prediction$real_rain_tomorrow, "accurate", "inaccurate"), br(),
        "Detail:", c_status)}
      
      ))
  
}
