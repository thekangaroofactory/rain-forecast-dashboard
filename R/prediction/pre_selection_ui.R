



# ------------------------------------------------------------------------------
# Module UI function
# ------------------------------------------------------------------------------

# -- function
pre_selection_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  div(class = "section",
      layout_columns(
        col_widths = c(1, 11),
        
        p(""),
        
        tagList(
          h2("Select predictions"),
          p("By default, all predictions are selected.", br(),
            "It's possible to tune the date range using the slider or buttons:"),
          uiOutput(ns("date_slider")))))
  
}
