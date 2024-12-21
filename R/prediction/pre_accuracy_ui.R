

pre_accuracy_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  div(class = "section",
      layout_columns(
        col_widths = c(1, 5, 5, 1),
        
        p(" "),
        
        tagList(
          h2("Accuracy over time"),
          p("This chart shows how the overall accuracy evolves over time as well as the good & bad predictions (stripes)."),
          p("Although accuracy is not a good metric by itself (it can lead to an overly-optimistic performance assessment),",
            "it's interresting to see how it evolves over times, and select corresponding period of time to zoom on.")),
        
        plotOutput(ns("accuracy_plot")),
        
        p(" ")))
  
}
