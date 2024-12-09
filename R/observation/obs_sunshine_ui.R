

# ------------------------------------------------------------------------------
# Module UI function
# ------------------------------------------------------------------------------

# -- function
obs_sunshine_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  layout_columns(
    col_widths = c(7, 5),
    
    tagList(
      h2("Sunshine"),
      p("This demonstrates the amont of sunshine per day over the period")
    ),

    plotOutput(ns("p_sunshine"), height = "600px")
        
    # card(
    #   class = "mycard",
    #   full_screen = TRUE,
    #   plotOutput(ns("p_sunshine")),
    #   p("Download the visualization")))
  
  )
    
}
