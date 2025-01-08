

# ------------------------------------------------------------------------------
# Server logic
# ------------------------------------------------------------------------------

observation_Server <- function(id, observations) {
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
    benchmark_radar <- reactiveVal(NULL)
    benchmark_sunshine <- reactiveVal(NULL)
    
    
    # -- compute dataset stats
    dataset_date_min <- min(observations$date)
    dataset_date_max <- max(observations$date)
    
    
    # --------------------------------------------------------------------------
    # Select data
    # --------------------------------------------------------------------------
    
    # -- selected observations
    selected_observations <- reactive(observations[observations$date >= as.Date(input$date_slider[1]) &
                                                     observations$date <= as.Date(input$date_slider[2]), ])
    
    
    # --------------------------------------------------------------------------
    # Outputs
    # --------------------------------------------------------------------------
    
    # -- header section values
    output$location <- renderText(unique(observations$location))
    output$nb_obs <- renderText(nrow(observations))
    output$days_with_rain <- renderText(paste0(round(sum(observations$rain_fall > 0, na.rm = TRUE) / nrow(observations) * 100), "%"))
    output$rainfall <- renderText(
      paste0(round(mean(observations[observations$rain_fall > 0, ]$rain_fall, na.rm = TRUE), digits = 1), "mm"))
    
    
    # -- summary section text
    output$dataset_summary <- renderText(
      paste(nrow(observations), "observations have been collected since", as.character(dataset_date_min)))
    
    # -- summary section latest obs
    output$latest_1 <- renderUI(
      observation_card(head(observations, n = 1)))
    
    output$latest_2 <- renderUI(
      observation_card(observations[2, ]))
    
    output$latest_3 <- renderUI(
      observation_card(observations[3, ]))
    
    # -- date slider
    output$date_range <- renderUI(
      div(style="display:inline-block",
      sliderInput(inputId = ns("date_slider"),
                  label = "Date range:",
                  min = dataset_date_min,
                  max = dataset_date_max,
                  value = c(as.Date(paste0(format(Sys.Date(), "%Y"), "-01-01")), dataset_date_max)),
      
      br(),
      
      actionButton(inputId = ns("previous_year"),
                   label = icon(name = "backward")),
      
      actionButton(inputId = ns("next_year"),
                   label = icon(name = "forward")),
      
      actionButton(inputId = ns("this_year"),
                   label = "This year"),
      
      actionButton(inputId = ns("all_years"),
                   label = "All")
      
      ))
    
    observeEvent(input$all_years, {
      
      updateSliderInput(inputId = "date_slider",
                        value = c(dataset_date_min, dataset_date_max))
      
    })
    
    
    observeEvent(input$this_year, {
      
      updateSliderInput(inputId = "date_slider",
                        value = c(as.Date("2024-01-01"), dataset_date_max))
      
    })
    
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
                        value = c(year_start, year_end))
      
    })
    
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
                        value = c(year_start, year_end))
      
    })
    
    
    # --------------------------------------------------------------------------
    # Radar plot section
    # --------------------------------------------------------------------------
    
    # -- benchmark
    output$benchmark_radar <- renderText(benchmark_radar())
    
    # -- radar plot
    output$p_radar <- renderPlot(
      
      # -- check data size
      if(nrow(selected_observations()) > 0){
        
        # -- benchmark
        ts_before <- ktools::getTimestamp()
        
        # -- build plot
        p <- radar(selected_observations())
        
        # -- benchmark
        ts_after <- ktools::getTimestamp()
        benchmark_radar(as.numeric(ts_after - ts_before))
        cat("Radar computation time =", benchmark_radar(), "ms \n")
        
        # -- return
        tryCatch(
          print(p),
          error = function(e) default_p(message = "Failed to build the plot:\nthe date range is too short.",
                                        size = 4,
                                        color = "grey"))}, 
      bg = "transparent")
    
    
    # --------------------------------------------------------------------------
    # Sunshine plot section
    # --------------------------------------------------------------------------
    
    # -- benchmark
    output$benchmark_sunshine <- renderText(benchmark_sunshine())
    
    # -- sunshine plot
    output$p_sunshine <- renderPlot(
      
      # -- check data size
      if(nrow(selected_observations()) > 0){
        
        # -- benchmark
        ts_before <- ktools::getTimestamp()
        
        # -- build plot
        p <- sunshine(selected_observations())
        
        # -- benchmark
        ts_after <- ktools::getTimestamp()
        benchmark_sunshine(as.numeric(ts_after - ts_before))
        cat("Sunshine computation time =", benchmark_sunshine(), "ms \n")
        
        # -- return
        p}, 
      
      bg = "transparent")
    
    
    # --------------------------------------------------------------------------
    # -- table
    #output$obs_table <- DT::renderDT(observations, fillContainer = TRUE)
    
    
  })
}
