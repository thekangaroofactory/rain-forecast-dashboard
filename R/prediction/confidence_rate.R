

#' Compute Confidence Rate
#'
#' @param predictions the data.frame of predictions
#' @param n the number of buckets
#'
#' @returns a data.frame of the buckets with confidence rate
#'
#' @examples

confidence_rate <- function(predictions, n = 100){
  
  # -- compute groups (buckets)
  predictions$group <- floor(predictions$scaled_prediction * n) / n
  
  # -- transform data
  predictions %>%
    group_by(group) %>%
    summarise(count = n(), 
              accurate = sum(accurate, na.rm = T),
              confidence = accurate / count)
  
}
