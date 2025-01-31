

call_api <- function(resource = "observations", station = "IDCJDW2124", start, end){
  
  # -- build url
  api_url <- paste0(WS_URL, WS_BASE_ROUTE, resource)
  cat("API url =", api_url, "\n")
  
  # -- init
  # tryCatch may not raise error for example when env variables are not set
  response <- NULL
  
  # -- call api
  tryCatch({
    response <- RCurl::getURL(api_url)
    cat("API call response size =", object.size(response) ,"\n")},
    
    error = function(e) {
      message(e$message)
      return(NULL)})

  # -- return
  jsonlite::fromJSON(response)
  
}
