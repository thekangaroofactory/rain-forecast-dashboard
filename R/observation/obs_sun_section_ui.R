

# ------------------------------------------------------------------------------
# Module UI function
# ------------------------------------------------------------------------------

# -- function
obs_sun_section_ui  <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  div(class = "section",
      layout_columns(
        col_widths = c(12),
        
        card(
          class = "container-card p-3",
          card_header(h4("Sunshine over the selected period")),
          card_body(
            layout_column_wrap(
              width = 1/3,
              
              value_box(
                title = "Total sunshine",
                theme = "bg-gradient-yellow-orange",
                value = textOutput(ns("sunshine_amount"))),
              
              value_box(
                title = "Mean",
                theme = "bg-gradient-yellow-orange",
                value = textOutput(ns("sunshine_mean"))),
              
              value_box(
                title = "Median",
                theme = "bg-gradient-yellow-orange",
                value = textOutput(ns("sunshine_median"))))))))

}
