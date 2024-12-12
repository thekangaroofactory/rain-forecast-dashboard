

# ------------------------------------------------------------------------------
# Server logic
# ------------------------------------------------------------------------------

prediction_Server <- function(id, predictions) {
  moduleServer(id, function(input, output, session) {
    
    # --------------------------------------------------------------------------
    # Parameters
    # --------------------------------------------------------------------------
    
    # -- trace
    MODULE <- paste0("[", id, "]")
    cat(MODULE, "Starting module server... \n")
    
    # -- namespace
    ns <- session$ns
    
    
    # --------------------------------------------------------------------------
    # Data selection
    # --------------------------------------------------------------------------
    
    # -- input
    output$date_slider <- renderUI(sliderInput(inputId = ns("date_slider"),
                                               label = "Date range",
                                               min = min(predictions$date),
                                               max = max(predictions$date),
                                               value = c(min(predictions$date), max(predictions$date))))
    
    # -- filter dataset
    selected_predictions <- reactive(
      predictions[predictions$date >= input$date_slider[1] & predictions$date <= input$date_slider[2], ])
    
    
    # --------------------------------------------------------------------------
    # Outputs
    # --------------------------------------------------------------------------
    
    # -- header values
    output$predict_nb <- renderText(nrow(selected_predictions()))
    output$predict_accurate <- renderText(sum(selected_predictions()$accurate, na.rm = TRUE))
    output$predict_accuracy <- renderText(paste0(
      round(sum(selected_predictions()$accurate, na.rm = TRUE) / nrow(selected_predictions()) * 100, digits = 2), "%"))
    
    
  })
}
