


pre_kpis_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  div(class = "section",
      layout_columns(
        col_widths = c(4, 4, 4),
        
        tagList(
          value_box(
            title = "Precision",
            theme = "bg-gradient-yellow-orange",
            value = textOutput(ns("precision"))),
          p("Precision is the fraction of accurate predictions among the positive ones.", br(),
            "It demonstrates the ability of the model to accurately predict rain.")),
        
        tagList(
          value_box(
            title = "Recall",
            theme = "bg-gradient-yellow-orange",
            value = textOutput(ns("recall"))),
          p("Recall is the fraction of actual positive occurences that were retrieved.", br(),
            "It demonstrates the ability of the model to retrieve days with rain.")),
        
        tagList(
          value_box(
            title = "F1 Score",
            theme = "bg-gradient-yellow-orange",
            value = textOutput(ns("f1_score"))),
          p("The F1 score is the harmonic mean of the precision and recall.", br(),
            "A value of 1 would mean perfect precition & recall."))))
  
}
