

# ------------------------------------------------------------------------------
# Module UI function
# ------------------------------------------------------------------------------

# -- function
obs_sunshine_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  div(class = "section",
      layout_columns(
        col_widths = c(7, 5),
        
        # -- plot
        plotOutput(ns("p_sunshine"), height = "600px"),
        
        # -- text
        tagList(
          h2("Sunshine"),
          
          p("This chart displays the amount of sunshine per day distribution", br(), 
            "over the selected period (hours per day):"),
          
          p("Horizontal lines show the range of values", br(),
            "Out of all observations:", br(),
            "- 50% are inside the boxes", br(),
            "- 50% are on each sides of the vertical lines (median)", br(),
            "- 25% are above or below the limits of the boxes", br()),
          
          p("Shadows display the distribution of values along the range"),
          
          tags$i("Computation time: ", textOutput(ns("benchmark_sunshine"), inline = T), "ms"))))
  
}
