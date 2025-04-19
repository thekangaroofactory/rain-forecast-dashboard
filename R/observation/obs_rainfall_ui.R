

# ------------------------------------------------------------------------------
# Module UI function
# ------------------------------------------------------------------------------

# -- function
obs_rainfall_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  div(class = "section",
      
      layout_columns(
        col_widths = c(6, 6),
        
        # -- text
        tagList(
          h2("Rainfall"),
          
          p("This chart displays the amount of rainfall per day distribution", br(),
            "as well as the number of days with rain over the selected period:"),
          
          p("Vertical lines show the range of values", br(),
            "Out of all observations:", br(),
            "- 50% are inside the boxes", br(),
            "- 50% are on each sides of the horizontal line in the box (median)", br(),
            "- 25% are above or below the limits of the boxes", br()),
          
          p("Shadows display the distribution of values along the range"),
          
          p("Orange vertical segments correspond to the number of days with rain"),
          
          tags$i("Computation time: ", textOutput(ns("benchmark_rainfall"), inline = T), "ms")),
        
        # -- plot
        plotOutput(ns("p_rainfall"), height = "600px")))
  
}
