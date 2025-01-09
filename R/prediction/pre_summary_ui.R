

# ------------------------------------------------------------------------------
# Module UI function
# ------------------------------------------------------------------------------

# -- function
pre_summary_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  div(class = "section",
      layout_columns(
        col_widths = c(6, 6),
        
        tagList(
          h2("Predictions"),
          p("This dashboard explores the performances of the prediction model."),
          
          p("First it's important to define the target of the model:", br(),
            "Here we want to retrieve all days with rain.", br(),
            "So the model was trained to output 1 when there's a 100% chance of rain tomorrow."),
          
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
              uiOutput(ns("latest_3")))))))
  
}
