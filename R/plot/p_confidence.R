

p_confidence <- function(predictions, spread = 0.1, n = 100){
  
  # -- data transformation
  data <- confidence_rate(predictions, n = n)
  
  
  # -- init
  ggplot(data) +
    
    # -- prediction split line
    geom_vline(
      xintercept = .5,
      color = "grey",
      linetype = "dotted",
      alpha = .25) +
    
    # -- density of scaled predictions
    geom_density(
      data = predictions,
      aes(x = scaled_prediction),
      color = "orange",
      fill = "grey",
      alpha = .15) +
    
    # -- accuracy points
    geom_point(
      aes(x = group,
          y = accurate / count - (1 + spread),
          size = count),
      shape = 21,
      color = "grey",
      alpha = 0.25) +
    
    # -- accuracy line
    geom_line(
      aes(x = group,
          y = accurate / count - (1 + spread),
          color = accurate / count)) +
    
    # -- accuracy area
    geom_ribbon(
      aes(x = group,
          ymin = accurate / count - (1 + spread)),
      ymax = -spread,
      fill = "grey",
      alpha = 0.15) +
    
    # -- color scale
    scale_color_gradient(low = "cyan", high = "orange") +
    
    # -- y axis & labels
    scale_y_continuous(breaks = c(-spread, -(0.25 + spread), -(0.5 + spread), -(1 + spread)),
                       labels = c("100%", "75%", "50%", "0%")) +
    
    # -- y axis & labels
    scale_x_continuous(breaks = c(0, 0.25, 0.5, 0.75, 1),
                       labels = c("0%", "25%", "50%", "75%", "100%")) +
    
    # -- titles
    labs(x = "Prédictions", y = NULL) +
    
    # -- theme
    theme(
      
      #panel.background = element_rect(fill = "#2d3037"),
      #plot.background = element_rect(fill = "#2d3037"),
      
      panel.background = element_blank(),
      plot.background = element_blank(),
      
      panel.grid = element_blank(),
      axis.title = element_text(color = "grey"),
      axis.text = element_text(color = "grey"),
      
      legend.position = "none")
  
  
}

 
#print(p_confidence(predictions_df, spread = 0.25, n = 100))
