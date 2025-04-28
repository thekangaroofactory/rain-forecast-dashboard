

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
    response <- RCurl::getURL(api_url, httpheader = c(Accept = "application/json", "X-API-KEY" = Sys.getenv("API_KEY")))
    cat("API call response size =", object.size(response) ,"\n")
    
    
    # -- skip if error
    if(!is.null(response)){
      
      if(DEBUG)      
        DEBUG_response <<- response
      
      # -- check 401 feedback
      if(grepl("Unauthorized", response)){
        message("[WARNING] API Authentication failed (code 401) -- Check API key")
        response <- NULL}}
    
  })
  
  
  # -- return
  if(!is.null(response))
    jsonlite::fromJSON(response)
  else
    NULL
  
}
