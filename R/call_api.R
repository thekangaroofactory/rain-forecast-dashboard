

call_api <- function(resource = "observations", station = "IDCJDW2124", start, end){
  
  # -- build url
  api_url <- paste0("http://127.0.0.1:4479", "/api/v1/", resource)
  
  # -- call api
  tryCatch({
    response <- RCurl::getURL(api_url)
    cat("API call response size =", object.size(response) ,"\n")},
    
    error = function(e) message(e$message),
    
    finally = response <- NULL)

  # -- return
  if(!is.null(response))
    jsonlite::fromJSON(response)
  else NULL
  
}
