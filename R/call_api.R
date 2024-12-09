

call_api <- function(resource = "observations", station = "IDCJDW2124", start, end){
  
  # -- build url
  api_url <- paste0("http://127.0.0.1:9107", "/api/v1/", resource)
  
  # -- call api
  response <- RCurl::getURL(api_url)
  cat("API call response size =", object.size(response) ,"\n")
  
  # -- get df
  jsonlite::fromJSON(response)
  
}
