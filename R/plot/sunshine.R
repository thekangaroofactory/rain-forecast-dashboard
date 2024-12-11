

sunshine <- function(data, family = ""){

  # -- params
  color_text <- "grey45"
  
  
  # -- filter out rows with sunshine NA
  data <- data[!is.na(data$sunshine), ]
  
  # -- build stats (to order)
  stats <- data %>%
    group_by(month) %>%
    summarise(cumsum = sum(sunshine, na.rm = TRUE),
              mean = mean(sunshine, na.rm = TRUE),
              median = median(sunshine, na.rm = TRUE)) %>%
    arrange(., -median) %>%
    mutate(name = month.name[month])
  
  
  # -- get max sunshine
  maxday <- data[!is.na(data$sunshine) & data$sunshine == max(data$sunshine, na.rm = T), ]
  maxvalue <- unique(maxday$sunshine)
  maxmonth <- names(which.max(table(maxday$month)))
  
  # -- build color palette
  color_palette <- c("#9d9d9d",
                     "#ad9a9e",
                     "#bd979c",
                     "#cc9497",
                     "#da9190",
                     "#e68f86",
                     "#f08d7a",
                     "#f88c6b",
                     "#fe8d5b",
                     "#ff8f48",
                     "#ff9330",
                     "#ff9900")
  
  # -- set names (months)
  names(color_palette) <- rev(stats$month)
  
  # -- Add Google Font
  font_add_google(name = "Lexend")
  
  # -- enable custom fonts
  showtext_auto()
  
  # -- init
  ggplot(data,
         aes(x = month,
             y = sunshine,
             fill = month)) +
    
    # -- vertical lines
    # otherwise they won't be in the background
    geom_hline(
      yintercept = c(5, 10),
      linetype = "dotted",
      color = color_text) +
    
    # -- background violin area
    geom_violinhalf(
      position = position_nudge(x = -0.05),
      flip = TRUE,
      colour = NA,
      alpha = 0.2) +
    
    # -- boxes + jitter
    geom_boxplot(width = 0.25) +
    geom_jitter(width = 0.1, alpha = 0.1) +
    
    # -- Legend: month name
    geom_text(
      data = stats,
      aes(x = month,
          y = 0,
          label = name),
      hjust = 0,
      vjust = 0,
      nudge_x = 0.2,
      family = family,
      fontface = "bold",
      size = 6,
      color = color_text) +
    
    # -- Legend: median sunshine
    geom_text(
      data = stats,
      aes(x = month,
          y = median,
          label = paste0(round(median, digits = 1), "h")),
      hjust = 0.5,
      vjust = 0,
      nudge_x = 0.25,
      family = family,
      fontface = "bold",
      size = 4,
      color = color_text) +
    
    # -- Legend: max sunshine
    geom_text(
      data = data.frame(month = maxmonth,
                        sunshine = maxvalue),
      aes(x = month,
          y = sunshine,
          label = paste0(round(sunshine, digits = 1), "h\nmax")),
      hjust = 0,
      vjust = 0,
      nudge_x = -0.6,
      family = family,
      fontface = "plain",
      size = 3.5,
      lineheight = 0.75,
      color = color_text) +
    
    # -- reorder month
    scale_x_discrete(limits = rev(stats$month), expand = c(0.07, 0)) +
    scale_y_continuous(breaks = c(0, 5, 10),) +
    
    # -- colors
    scale_fill_manual(values = color_palette) +
    
    # -- make horizontal
    coord_flip() +
    
    # -- theme
    theme(
      
      plot.margin = margin(t = 20,
                           b = 10),

      # -- backgrounds & grid
      
      #panel.background = element_rect(fill = "#2d3037"),
      #plot.background =  element_rect(fill = "#2d3037"),
      
      panel.background = element_blank(),
      plot.background = element_blank(),
      panel.grid = element_blank(),
            
      # -- legend
      legend.position = "none",
      
      # -- axis
      axis.title.y = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks.y = element_blank(),
      axis.title.x = element_blank(),
      axis.text.x = element_text(family = family),
      
      )
  
}

#print(sunshine(observations_df))
