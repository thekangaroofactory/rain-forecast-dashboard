

p_copyright <- function(p){
  
  # -- add footnote
  p + 
    
    labs(caption = "© 2025 Philippe Peret") +
    theme(plot.caption = element_text(color = "grey",
                                      size = 7,
                                      hjust = 0))
  
}
