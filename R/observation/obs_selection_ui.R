



# ------------------------------------------------------------------------------
# Module UI function
# ------------------------------------------------------------------------------

# -- function
obs_selection_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  layout_columns(
    col_widths = c(1, 11),
    
    p(""),
    
    tagList(
      h2("Select observations"),
      p("By default, the observations corresponding to the current year are selected.", br(),
      "It's possible to tune the date range using the slider or buttons:"),
      uiOutput(ns("date_range"))))
    
}
