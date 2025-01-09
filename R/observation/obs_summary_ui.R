

# ------------------------------------------------------------------------------
# Module UI function
# ------------------------------------------------------------------------------

# -- function
obs_summary_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  div(class = "section",
      layout_columns(
        col_widths = c(6, 4),
        
        # -- Text
        tagList(
          h2("Observations"),
          p("The observation dashboard explores the weather data as collected from the source.", br(),
            "The Australian Government - Bureau of Meteorology (BOM)"),
          p("The data are downloaded daily from the BOM website.", br(),
            textOutput(ns("dataset_summary"), inline = TRUE))),
        
        # -- Cards
        card(
          class = "container-card",
          card_header(h4("Latest Observation")),
          card_body(
            layout_column_wrap(
              width = 1/3,
              uiOutput(ns("latest_1")),
              uiOutput(ns("latest_2")),
              uiOutput(ns("latest_3")))),
          card_footer(
            tags$i(style = "font-size: 9pt;", "Same-day observation is usually incomplete as 
               variables cannot be computed before the end of the day.")))))
    
}
