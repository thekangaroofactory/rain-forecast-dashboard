
# --
# This is the server logic of a Shiny web application.
# --

library(shiny)

# Define server logic
function(input, output, session) {
  
  # --------------------------------------
  # Load datasets
  
  # -- get available observations & transform
  observations <- call_api(resource = "observations")
  if(!is.null(observations))
    observations <- obs_datamart(observations)
  else
    showModal(
      modalDialog(
        title = "Data Error",
        p("The was a problem while retrieving the data from the database."),
        p("All values & plots will be empty.")))
  
  observations_df <<- observations
  
  # -- get predictions
  predictions <- call_api(resource = "predictions")
  predictions$date <- as.Date(predictions$date)
  predictions$expect_rain <- predictions$raw_prediction >= 0.28
  predictions$accurate <- predictions$expect_rain == observations[match(predictions$date, observations$date), ]$rain_tomorrow
  
  
  # ----------------------------------------------------------------------------
  # Start module servers
  
  # -- observation server
  observation_Server(id = "obs", observations)
  prediction_Server(id = "pre", predictions)
  
}
