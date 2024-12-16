


pre_kpis_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  layout_columns(
    col_widths = c(3, 3),
    
    value_box(
      title = "Precision",
      theme = "bg-gradient-yellow-orange",
      value = textOutput(ns("precision"))),
    
    value_box(
      title = "Recall",
      theme = "bg-gradient-yellow-orange",
      value = textOutput(ns("recall"))),
    
    value_box(
      title = "F1 Score",
      theme = "bg-gradient-yellow-orange",
      value = textOutput(ns("f1_score"))))
  
}
