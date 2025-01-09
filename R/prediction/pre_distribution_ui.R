

pre_distribution_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  div(class = "section",
      layout_columns(
        col_widths = c(6, 6),
        
        tagList(
          h2("Distribution"),
          p("The top part of the plot displays the distribution of predictions (from 0% chance of rain to 100%)", br(),
            "The bottom part shows the accuracy accross specific ranges of predictions that can be tuned."),
          div(style="display:inline-block",
          sliderInput(inputId = ns("nb_buckets"),
                      label = "Nb buckets",
                      min = 20,
                      max = 200,
                      value = 100,
                      step = 10))),
        
        plotOutput(ns("distribution_plot"))))
  
}
