
# --
# This is the server logic of a Shiny web application.
# --

# Define server logic
function(input, output, session) {
  
  # --------------------------------------
  # Init
  
  cat("Starting application server... \n")
  
  # -- check debug mode
  if(DEBUG)
    cat("[i] ***** DEBUG mode is ON ***** \n")
  
  
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
        p("There was a problem while retrieving the data from the database."),
        p("All values & plots will be empty.")))
  
  # -- debug
  if(DEBUG)
    observations_df <<- observations
  
  # -- get predictions
  predictions <- call_api(resource = "predictions")
  if(!is.null(predictions))
    predictions <- pre_datamart(predictions, observations)
  
  # -- debug
  if(DEBUG)
    predictions_df <<- predictions
  
  
  # ----------------------------------------------------------------------------
  # Start module servers
  
  # -- observation server
  if(!is.null(observations))
    observation_Server(id = "obs", observations)
  
  # -- prediction server
  if(!is.null(observations) && !is.null(predictions))
    prediction_Server(id = "pre", predictions, observations)
  
}
