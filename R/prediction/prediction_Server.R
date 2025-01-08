

# ------------------------------------------------------------------------------
# Server logic
# ------------------------------------------------------------------------------

prediction_Server <- function(id, predictions, observations) {
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
    
    
    # -- compute dataset stats
    dataset_date_min <- min(predictions$date)
    dataset_date_max <- max(predictions$date)
    
    
    # --------------------------------------------------------------------------
    # Scale predictions
    # --------------------------------------------------------------------------
    # will be moved when multi model is supported ***
    
    predictions <- scale_predictions(predictions, threshold = 0.28)
    
    
    # --------------------------------------------------------------------------
    # Data selection
    # --------------------------------------------------------------------------
    
    # -- input
    output$date_slider <- renderUI(
      div(style="display:inline-block",
          sliderInput(inputId = ns("date_slider"),
                      label = "Date range:",
                      min = dataset_date_min,
                      max = dataset_date_max,
                      value = c(dataset_date_min, dataset_date_max)),
          
          br(),
          
          actionButton(inputId = ns("previous_year"),
                       label = icon(name = "backward")),
          
          actionButton(inputId = ns("next_year"),
                       label = icon(name = "forward")),
          
          actionButton(inputId = ns("this_year"),
                       label = "This year"),
          
          actionButton(inputId = ns("all_years"),
                       label = "All")))
    
    
    # -- all_years
    observeEvent(input$all_years,
      updateSliderInput(inputId = "date_slider",
                        value = c(dataset_date_min, dataset_date_max)))
    
    
    # -- this_year
    observeEvent(input$this_year,
      updateSliderInput(inputId = "date_slider",
                        value = c(as.Date(paste0(format(Sys.Date(), "%Y"), "-01-01")), dataset_date_max)))
    
    
    # -- previous_year
    observeEvent(input$previous_year, {
      
      # -- check 
      req(input$date_slider[1] != dataset_date_min)
      
      # -- remove 1 year
      year <- lubridate::year(input$date_slider[1])
      if(year != lubridate::year(dataset_date_min))
        year <- year - 1
      
      # -- compute start / end
      year_start <- as.Date(paste(year, "01-01", sep = "-"))
      year_end <- as.Date(paste(year, "12-31", sep = "-"))
      
      # -- update input
      updateSliderInput(inputId = "date_slider",
                        value = c(year_start, year_end))})
    
    
    # -- next_year
    observeEvent(input$next_year, {
      
      # -- check 
      req(input$date_slider[1] != dataset_date_max)
      
      # -- remove 1 year
      year <- lubridate::year(input$date_slider[2])
      if(year != lubridate::year(dataset_date_max))
        year <- year + 1
      
      # -- compute start / end
      year_start <- as.Date(paste(year, "01-01", sep = "-"))
      year_end <- as.Date(paste(year, "12-31", sep = "-"))
      
      # -- update input
      updateSliderInput(inputId = "date_slider",
                        value = c(year_start, year_end))})
    
    
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


    # -- debug
    if(DEBUG)
      predictions_df <<- predictions


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
    # Summary section
    # --------------------------------------------------------------------------
    
    # -- latest predictions
    output$latest_1 <- renderUI(
      prediction_card(tail(predictions, n = 1)))
    
    output$latest_2 <- renderUI(
      prediction_card(predictions[nrow(predictions) - 1, ]))
    
    output$latest_3 <- renderUI(
      prediction_card(predictions[nrow(predictions) - 2, ]))
    
    
    
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
