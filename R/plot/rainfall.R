

#' Rainfall Plot
#'
#' @param data a data.frame of the data
#' @param family a font family to be passed to geom_text function calls
#'
#' @returns a ggplot object
#'
#' @examples


rainfall <- function(data, family = ""){

  # -- params
  color_text <- "grey45"
  
  # -- build color palette
  color_palette <- c("#9d9d9d",
                     "#91a2a6",
                     "#84a6ad",
                     "#76abb5",
                     "#69afbd",
                     "#5cb3c4",
                     "#4fb7cc",
                     "#42bbd3",
                     "#35bfdb",
                     "#27c4e3",
                     "#1ac8ea",
                     "#0dccf2")
  
  # -- filter out rows with rain_fall NA or 0 (no rain)
  data <- data[!is.na(data$rain_fall), ]
  data <- data[data$rain_fall > 0, ]
  
  # -- build stats (to order)
  stats <- data %>%
    group_by(month) %>%
    summarise(median = median(rain_fall, na.rm = TRUE),
              count = n()) %>%
    arrange(., median) %>%
    mutate(name = month.name[month])
  
  # -- get max rain_fall
  maxday <- data[!is.na(data$rain_fall) & data$rain_fall == max(data$rain_fall, na.rm = T), ]
  maxvalue <- unique(maxday$rain_fall)
  maxmonth <- names(which.max(table(maxday$month)))
  
  # -- set names (months)
  names(color_palette) <- stats$month
  
  # -- enable custom fonts
  showtext::showtext_auto()
  
  # -- init
  ggplot(data,
         aes(x = month,
             y = -rain_fall,
             fill = month)) +
    
    # -- vertical lines
    # otherwise they won't be in the background
    geom_hline(
      yintercept = -c(maxvalue/4, maxvalue/2),
      linetype = "dotted",
      color = color_text,
      alpha = .5) +

    # -- background violin area
    see::geom_violinhalf(
      position = position_nudge(x = -0.05),
      flip = FALSE,
      colour = NA,
      alpha = 0.2) +

    # -- boxes + jitter
    geom_boxplot(width = 0.25) +
    geom_jitter(
      aes(
        size = rain_fall,
        color = rain_fall,
        alpha = rain_fall
      ),
      width = 0.1
      ) +
    
    # -- Legend: month name
    geom_text(
      data = stats,
      aes(x = month,
          y = -maxvalue,
          label = name),
      hjust = 0,
      vjust = 0,
      nudge_x = -0.08,
      angle = 90,
      family = family,
      fontface = "bold",
      size = 6,
      color = color_text) +
    
    # -- Legend: median rain_fall
    geom_text(
      data = stats,
      aes(x = month,
          y = -median,
          label = paste0(round(median, digits = 2), "mm")),
      hjust = 0,
      vjust = 0.5,
      nudge_x = 0.2,
      family = family,
      fontface = "plain",
      size = 3.5,
      lineheight = 0.75,
      color = color_text) +
    
    # -- Legend: max rain_fall
    geom_text(
      data = data.frame(month = maxmonth,
                        rain_fall = maxvalue),
      aes(x = month,
          y = -rain_fall,
          label = paste0(round(rain_fall, digits = 1), "mm\nmax")),
      hjust = 0,
      vjust = 1,
      nudge_x = 0.1,
      family = family,
      fontface = "plain",
      size = 3.5,
      lineheight = 0.75,
      color = color_text) +
    
    # -- Count (nb days with rain)
    geom_segment(data = stats,
                 aes(x = month,
                     y = -maxvalue,
                     yend = -maxvalue + maxvalue * (count / max(count) / 2)),
                 linewidth = 0.5,
                 lineend = "round",
                 color = "orange",
                 alpha = .75) +
    
    # -- Legend: count (nb days with rain)
    geom_text(
      data = stats,
      aes(x = month,
          y = -maxvalue + maxvalue * (count / max(count) / 2),
          label = count),
      hjust = 0,
      vjust = 0.5,
      nudge_x = 0.1,
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
      axis.text.x = element_blank(),
      axis.ticks.x = element_blank()
      
      )
  
}

# print(rainfall(observations_df))
