

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
    benchmark_rainfall <- reactiveVal(NULL)
    
    
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
    
    
    # -- date range selection
    output$date_range <- renderUI(
      
      # -- slider input
      div(style="display:inline-block",
          sliderInput(inputId = ns("date_slider"),
                      label = "Date range:",
                      min = dataset_date_min,
                      max = dataset_date_max,
                      value = c(as.Date(paste0(format(Sys.Date(), "%Y"), "-01-01")), dataset_date_max)),
          
          # -- spacing
          br(),
          
          # -- buttons
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
        p <- p_radar(selected_observations())
        p <- p_copyright(p)
        
        # -- benchmark
        ts_after <- ktools::getTimestamp()
        benchmark_radar(as.numeric(ts_after - ts_before))
        cat("Radar computation time =", benchmark_radar(), "ms \n")
        
        # -- return
        tryCatch(
          print(p),
          error = function(e) p_default(message = "Failed to build the plot:\nthe date range is too short.",
                                        size = 4,
                                        color = "grey"))}, 
      bg = "transparent")
    
    
    # --------------------------------------------------------------------------
    # Sunshine section
    # --------------------------------------------------------------------------
    
    # -- value boxes
    output$sunshine_amount <- renderText(paste0(sum(selected_observations()$sunshine, na.rm = T), "h"))
    output$sunshine_mean <- renderText(paste0(round(mean(selected_observations()$sunshine, na.rm = T), digits = 1), "h"))
    output$sunshine_median <- renderText(paste0(round(median(selected_observations()$sunshine, na.rm = T), digits = 1), "h"))
    
    
    # -- benchmark
    output$benchmark_sunshine <- renderText(benchmark_sunshine())
    
    # -- sunshine plot
    output$p_sunshine <- renderPlot(
      
      # -- check data size
      if(nrow(selected_observations()) > 0){
        
        # -- benchmark
        ts_before <- ktools::getTimestamp()
        
        # -- build plot
        p <- p_sunshine(selected_observations())
        p <- p_copyright(p)
        
        # -- benchmark
        ts_after <- ktools::getTimestamp()
        benchmark_sunshine(as.numeric(ts_after - ts_before))
        cat("Sunshine computation time =", benchmark_sunshine(), "ms \n")
        
        # -- return
        p}, 
      
      bg = "transparent")
    
    
    # --------------------------------------------------------------------------
    # Rainfall section
    # --------------------------------------------------------------------------
    
    # -- value boxes
    output$rainfall_amount <- renderText(paste0(sum(selected_observations()$rain_fall, na.rm = T), "mm"))
    output$rainfall_days <- renderText(sum(selected_observations()$rain_today, na.rm = T))
    output$rainfall_days_rate <- renderText(paste0(round(sum(selected_observations()$rain_today, na.rm = T) / nrow(selected_observations()) * 100, digits = 0), "%"))
    
    
    # -- benchmark
    output$benchmark_rainfall <- renderText(benchmark_rainfall())
    
    # -- rainfall plot
    output$p_rainfall <- renderPlot(
      
      # -- check data size
      if(nrow(selected_observations()) > 0){
        
        # -- benchmark
        ts_before <- ktools::getTimestamp()
        
        # -- build plot
        p <- p_rainfall(selected_observations())
        p <- p_copyright(p)
        
        # -- benchmark
        ts_after <- ktools::getTimestamp()
        benchmark_rainfall(as.numeric(ts_after - ts_before))
        cat("Rainfall computation time =", benchmark_rainfall(), "ms \n")
        
        # -- return
        p}, 
      
      bg = "transparent")
    
  })
}
