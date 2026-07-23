

p_copyright <- function(p){
  
  # -- add footnote
  p + 
    
    labs(caption = paste("©", format(Sys.Date(), "%Y"), "Philippe Peret")) +
    theme(plot.caption = element_text(color = "grey",
                                      size = 7,
                                      hjust = 0))
  
}
