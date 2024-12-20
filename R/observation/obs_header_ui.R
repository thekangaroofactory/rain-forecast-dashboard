

# ------------------------------------------------------------------------------
# Module UI function
# ------------------------------------------------------------------------------

# -- function
obs_header_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  layout_columns(
    col_widths = c(3, 3, 3, 3),
    
    # -- Location
    value_box(
      title = "Location",
      theme = "bg-gradient-yellow-orange",
      value = uiOutput(ns("location"))),
    
    # -- Observations
    value_box(
      title = "Observations",
      theme = "bg-gradient-yellow-orange",
      value = uiOutput(ns("nb_obs"))),
    
    # -- Days with rain
    value_box(
      title = "Days with rain",
      theme = "bg-gradient-yellow-orange",
      value = uiOutput(ns("days_with_rain"))),
    
    # -- xxx
    value_box(
      title = "Average rainfall",
      theme = "bg-gradient-yellow-orange",
      value = uiOutput(ns("rainfall"))))
  
}
