

# ------------------------------------------------------------------------------
# Module UI function
# ------------------------------------------------------------------------------

# -- function
pre_summary_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  layout_columns(
    col_widths = c(1, 6, 4, 1),
    
    p(""),
    
    tagList(
      h2("Predictions"),
      p("The predictions dashboard explores the performances of the prediction model.", br()),
      
      p("Some predictions may be filtered in case it is not possible to check their accuracy.", br(),
        "This happens when the rainfall value is missing in the corresponding observation.")),
    
    card(
      class = "container-card",
      card_header(h4("Latest Predictions")),
      card_body(
        layout_column_wrap(
          width = 1/3,
          uiOutput(ns("latest_1")),
          uiOutput(ns("latest_2")),
          uiOutput(ns("latest_3"))))))
    
}
