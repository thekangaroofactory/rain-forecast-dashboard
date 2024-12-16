

pre_accuracy_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  layout_columns(
    col_widths = c(5, 6, 1),
    
    h2("Accuracy over time"),
    
    plotOutput(ns("accuracy_plot")),
    
    p(" "))
  
}
