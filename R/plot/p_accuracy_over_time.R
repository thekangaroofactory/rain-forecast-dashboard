
p_accuracy_over_time <- function(predictions, theme = COLORS){
  
  # -- init
  ggplot(predictions,
         aes(
           x = date)) +
    
    geom_line(
      aes(
        y = cum_accuracy),
      color = theme$p_warm) +
    
    geom_hline(
      aes(
        yintercept = max(cumsum, na.rm = T) / max(count, na.rm = T)),
      linetype = "dotted",
      color = "grey75") +
    
    geom_segment(
      data = predictions[predictions$accurate %in% c(TRUE, FALSE), ],
      aes(
        yend = ifelse(accurate, 0.1, -0.1) - 0.25,
        color = ifelse(accurate, theme$p_warm, theme$p_cold)),
      y = -0.25,
      linewidth = 0.1) +
    
    scale_y_continuous(breaks = c(0, 0.2, 0.4, 0.6, 0.8),
                       labels = c("0", "20%", "40%", "60%", "80%")) +
    
    # -- theme
    theme(
      legend.position = "none",
      plot.background = element_blank(),
      panel.background = element_blank(),
      panel.grid = element_blank(),
      axis.title = element_blank(),
      axis.text = element_text(color = "grey75"),
      axis.ticks = element_line(color = "grey75"))
  
}

#print(p_accuracy_over_time(predictions_df))
