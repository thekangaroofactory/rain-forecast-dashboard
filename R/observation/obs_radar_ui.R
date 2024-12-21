

# ------------------------------------------------------------------------------
# Module UI function
# ------------------------------------------------------------------------------

# -- function
obs_radar_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  div(class = "section",
      layout_columns(
        col_widths = c(7, 5),
        
        # -- the plot
        plotOutput(ns("p_radar"), height = "800px"),
        
        # -- the text
        tagList(
          h2("Radar"),
          "This data visualization displays the following features (from the center):", br(),
          tags$ul(
            tags$li("Min & max temperatures"),
            tags$li("Rainfall"),
            tags$li("Cloud 9am / 3pm"),
            tags$li("Sunshine")),
          
          "Daily observations are projected clockwise around the radial plot.", br(),
          "The stripes in the background show austral winter & summer seasons",
          
          tags$i("Computation time: ", textOutput(ns("benchmark_radar"), inline = T), "ms"))))
  
}
