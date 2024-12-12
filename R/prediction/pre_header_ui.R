


pre_header_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  layout_columns(
    col_widths = c(3, 3),
    
    value_box(
      title = "Predictions",
      theme = "bg-gradient-yellow-orange",
      value = uiOutput(ns("predict_nb"))),
    
    value_box(
      title = "Accurate",
      theme = "bg-gradient-yellow-orange",
      value = uiOutput(ns("predict_accurate"))),
    
    value_box(
      title = "Accuracy",
      theme = "bg-gradient-yellow-orange",
      value = uiOutput(ns("predict_accuracy"))))
  
}
