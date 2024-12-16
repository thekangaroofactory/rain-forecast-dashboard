


pre_header_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  layout_columns(
    col_widths = 3,
    
    value_box(
      title = "Model",
      theme = "bg-gradient-yellow-orange",
      value = textOutput(ns("predict_model"))),
    
    value_box(
      title = "Predictions",
      theme = "bg-gradient-yellow-orange",
      value = uiOutput(ns("predict_nb")),
      textOutput(ns("predict_removed"))),
    
    value_box(
      title = "Accurate",
      theme = "bg-gradient-yellow-orange",
      value = uiOutput(ns("predict_accurate")),
      textOutput(ns("predict_inaccurate"))),
    
    value_box(
      title = "Accuracy",
      theme = "bg-gradient-yellow-orange",
      value = uiOutput(ns("predict_accuracy")),
      textOutput(ns("predict_inaccuracy"))))
  
}
