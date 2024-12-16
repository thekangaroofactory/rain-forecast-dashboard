

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
    
    # -- reactive objects
    nb_removed <- reactiveVal(NULL)
    
    
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
    selected_predictions <- reactive({
      
      # -- check if input is initialized
      req(input$date_slider)
      
      # -- filter
      pre <- predictions %>%
        filter(
          date >= input$date_slider[1],
          date <= input$date_slider[2])
      
      # -- store nb removed in next step
      nb_removed(sum(!pre$accurate %in% c(TRUE, FALSE)))
      
      # -- filter out NA
      pre %>%
        filter(
          accurate %in% c(TRUE, FALSE))
      
    })
    
    # -- confusion matrix
    c_matrix <- reactive(confusion_matrix(selected_predictions()))

    
    # **************************************************************************
    # **************************************************************************
    predictions_df <<- predictions
    # **************************************************************************
    # **************************************************************************
    
    
    # --------------------------------------------------------------------------
    # Header section
    # --------------------------------------------------------------------------
    
    output$predict_model <- renderText("M1")
    
    output$predict_removed <- renderText(paste(nb_removed(), "predictions filtered"))
    
    # -- header values
    output$predict_nb <- renderText(nrow(selected_predictions()))
    
    # -- accurate / not accurate
    output$predict_accurate <- renderText(sum(selected_predictions()$accurate))
    output$predict_inaccurate <- renderText(
      paste(sum(!selected_predictions()$accurate), "predictions KO"))
    
    # -- accuracy %
    output$predict_accuracy <- renderText(paste0(
      round(sum(selected_predictions()$accurate) / nrow(selected_predictions()) * 100, digits = 2), "%"))
    output$predict_inaccuracy <- renderText(paste0(
      round(sum(!selected_predictions()$accurate) / nrow(selected_predictions()) * 100, digits = 2), "% predictions KO"))
    
    
    # --------------------------------------------------------------------------
    # Confusion matrix section
    # --------------------------------------------------------------------------
    
    # -- confusion matrix plot
    output$confusion_plot <- renderPlot(p_confusion_matrix(c_matrix()), bg = "transparent")
    
    
    # --------------------------------------------------------------------------
    # Accuracy over time section
    # --------------------------------------------------------------------------
    
    # -- accuracy evolution
    output$accuracy_plot <- renderPlot(p_accuracy_over_time(selected_predictions()), bg = "transparent")
    
    
    # --------------------------------------------------------------------------
    # Precision / recall section
    # --------------------------------------------------------------------------
    
    # -- precision / recall
    precision <- reactive(c_matrix()$true_positive / (c_matrix()$true_positive + c_matrix()$false_negative))
    recall <- reactive(c_matrix()$true_positive / (c_matrix()$true_positive + c_matrix()$false_positive))
    
    # -- F1 score
    f1_score <- reactive(2 * (recall() * precision()) / (recall() + precision()))
    
    # -- outputs
    output$precision <- renderText(round(precision(), digits = 2))
    output$recall <- renderText(round(recall(), digits = 2))
    output$f1_score <- renderText(round(f1_score(), digits = 2))
    
    
  })
}
