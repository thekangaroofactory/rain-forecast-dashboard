


pre_confusion_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  layout_columns(
    col_widths = c(5, 6, 1),
    
    h2("Confusion Matrix"),
    
    plotOutput(ns("confusion_plot")),
    
    p(" "))
  
}
