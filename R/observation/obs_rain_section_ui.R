

# ------------------------------------------------------------------------------
# Module UI function
# ------------------------------------------------------------------------------

# -- function
obs_rain_section_ui  <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  div(class = "section",
      layout_columns(
        col_widths = c(12),
        
        card(
          class = "container-card p-3",
          card_header(h4("Rain over the selected period")),
          card_body(
            layout_column_wrap(
              width = 1/3,
              
              value_box(
                title = "Total rainfall",
                theme = "bg-gradient-yellow-orange",
                value = textOutput(ns("rainfall_amount"))),
              
              value_box(
                title = "Days with rain",
                theme = "bg-gradient-yellow-orange",
                value = textOutput(ns("rainfall_days"))),
              
              value_box(
                title = "Amout of days with rain",
                theme = "bg-gradient-yellow-orange",
                value = textOutput(ns("rainfall_days_rate"))))))))

}
