

p_confusion_matrix <- function(c_mat){
  
  # -- nb predictions
  nb_pre <- sum(c_mat)
  
  # -- data preparation
  df <- data.frame(
    
    # -- x based on normalized radiuses
    x = c(0, c_mat$true_positive / nb_pre * 100, 100, 100 + c_mat$true_negative / nb_pre * 100),
    
    # -- values
    value = c(c_mat$true_positive, 
              c_mat$false_positive, 
              c_mat$true_negative,
              c_mat$false_negative),
    
    # -- normalize values
    radius = c(c_mat$true_positive / nb_pre * 100, 
               c_mat$false_positive / nb_pre * 100, 
               c_mat$true_negative / nb_pre * 100,
               c_mat$false_negative / nb_pre * 100),
    
    # -- good / bad
    color = c(1,0,1,0))
  
  
  # -- build plot & return
  ggplot(df,
         aes(color = color)) +
    
    # -- circular area
    ggforce::geom_circle(
      aes(x0 = x,
          y0 = 0,
          r = radius,
          fill = color),
      alpha = 0.3) +
    
    # -- value
    geom_text(
      aes(x = x,
          label = value),
      y = 0,
      size = 5) +
    
    # -- fill & color
    scale_colour_gradient(low = "grey", high = "orange") +
    scale_fill_gradient(low = "grey", high = "orange") +
    
    # -- keep it 'squared'
    coord_fixed() +
    
    # -- theme
    theme(
      legend.position = "none",
      plot.background = element_blank(),
      panel.background = element_blank(),
      panel.grid = element_blank(),
      axis.title = element_blank(),
      axis.text = element_blank(),
      axis.ticks = element_blank())
  
}

#print(p_confusion_matrix(c_matrix))
