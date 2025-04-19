


p_default <- function(message = "Failed to build the plot.", size = 6, color = "red"){
  
  # -- init
  ggplot() +
    
    # -- display message
    annotate("text", 
             label = message,
             x = 1, 
             y = 1, 
             size = size, 
             color = color) +
    
    # -- remove all
    theme(axis.line=element_blank(),
          axis.text.x=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks=element_blank(),
          axis.title.x=element_blank(),
          axis.title.y=element_blank(),
          legend.position="none",
          panel.background=element_blank(),
          panel.border=element_blank(),
          panel.grid.major=element_blank(),
          panel.grid.minor=element_blank(),
          plot.background=element_blank())
  
}
