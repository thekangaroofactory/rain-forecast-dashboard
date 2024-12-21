


pre_confusion_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  div(class = "section",
      layout_columns(
        col_widths = c(1, 5, 5, 1),
        
        # -- dummy
        p(" "),
        
        # -- plot
        plotOutput(ns("confusion_plot")),
        
        # -- text
        tagList(
          h2("Confusion Matrix"),
          p("This metric helps to understand how the model performs among the different classes (here rain / no rain)."),
          p("It's usually displayed as a 2x2 matrix.", br(),
            "Here we chose to have something more graphical to fit with the spirit of the dashbaord.")),
        
        # -- dummy
        p(" ")))
  
}
