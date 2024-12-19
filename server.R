
# --
# This is the server logic of a Shiny web application.
# --

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
  
  # -- debug
  if(DEBUG)
    observations_df <<- observations
  
  # -- get predictions
  predictions <- call_api(resource = "predictions")
  if(!is.null(predictions))
    predictions <- pre_datamart(predictions, observations)
  
  
  # ----------------------------------------------------------------------------
  # Start module servers
  
  # -- observation server
  observation_Server(id = "obs", observations)
  prediction_Server(id = "pre", predictions)
  
}
