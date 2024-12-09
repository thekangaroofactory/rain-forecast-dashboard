

# ------------------------------------------------------------------------------
# Server logic
# ------------------------------------------------------------------------------

data_Server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    # --------------------------------------------------------------------------
    # Parameters
    # --------------------------------------------------------------------------
    
    # -- trace
    MODULE <- paste0("[", id, "]")
    cat(MODULE, "Starting module server... \n")
    
    
    
    # -- Module return value
    list(observations = observations,
         predictions = predictions)
        
  })
}
