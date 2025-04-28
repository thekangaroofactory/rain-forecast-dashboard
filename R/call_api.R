

call_api <- function(resource = "observations", station = "IDCJDW2124", start, end){
  
  # -- build url
  api_url <- paste0(WS_URL, WS_BASE_ROUTE, resource)
  cat("API url =", api_url, "\n")
  
  # -- init
  # tryCatch may not raise error for example when env variables are not set
  response <- NULL
  
  # -- call api
  tryCatch({
    
    # -- try to call API
    response <- RCurl::getURL(api_url)
    cat("API call response size =", object.size(response) ,"\n")
    
    },
    
    # -- error management
    error = function(e) {
      
      cat("[WARNING] An error has been catched: \n")
      message(e$message)})

  # -- return
  if(!is.null(response))
    jsonlite::fromJSON(response)
  else
    NULL
  
}
