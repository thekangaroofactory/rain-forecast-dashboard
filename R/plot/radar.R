

radar <- function(observations){
  
  # -- scale values (rainfall values are large compared to temp / sunshine)
  coeff_rainfall <- 10
  
  # -- define y levels
  y_rainfall <- 55
  y_cloud <- 55
  y_sunshine <- 80
  y_seasons <- 90
  y_limit <- 95
  
  
  # -- compute helper values
  maximum_temp <- max(c(observations$min_temp, observations$max_temp), na.rm = T)
  median_temp <- median(c(observations$min_temp, observations$max_temp), na.rm = T)
  minimum_temp <- min(c(observations$min_temp, observations$max_temp), na.rm = T)
  
  # -- compute years & seasons
  years_start <- as.Date(paste(unique(format(observations$date, "%Y")), "01-01", sep = "-"))
  seasons <- compute_seasons(observations)
  
  # - compute separators date
  year_separators <- c(years_start[years_start >= min(observations$date)], max(observations$date))
  
  # -- init
  ggplot(observations,
         aes(x = date)) +
    
    # -- years & seasons -------------------------------------------------------

    # -- winters & summers
    geom_rect(
      data = seasons,
      inherit.aes = FALSE,
      aes(
        xmin = start,
        xmax = end,
        ymin = 0,
        ymax = y_seasons),
      alpha = 0.25) +
  
    # -- years
    geom_vline(
      xintercept = as.numeric(year_separators),
      color = "grey45",
      alpha = 0.5) +
    
    
    # -- temperatures ----------------------------------------------------------
  
    # -- median temperature
    geom_hline(
      yintercept = median_temp,
      color = "beige",
      alpha = 0.25,
      linewidth = 0.25) +
    
    # -- temperature (min-max range)
    geom_ribbon(
      aes(
        ymin = min_temp,
        ymax = max_temp),
      fill = "beige",
      alpha = 0.25) +
    
    # -- min temperature
    geom_line(
      aes(
        y = min_temp,
        colour = min_temp,
        alpha = (median_temp - min_temp) / (median_temp - min(min_temp, na.rm = T))),
      linewidth = 0.25) +
    
    # -- max temperature
    geom_line(
      aes(
        y = max_temp,
        colour = max_temp,
        alpha = (max_temp - median_temp) / (max(max_temp, na.rm = T) - median_temp)),
      linewidth = 0.25) +
    
    # -- gradient stroke
    scale_colour_gradient2(low = "cyan", mid = "beige" , high = "orange",
                           midpoint = median(c(observations$min_temp, observations$max_temp), na.rm = T)) +
    
    # -- init new scale
    ggnewscale::new_scale_colour() +
    
    
    # -- rainfall --------------------------------------------------------------
    
    # -- rainfall
    geom_point(
      data = observations[observations$rain_fall > 0 & !is.na(observations$rain_fall), ],
      aes(
        y = -rain_fall / coeff_rainfall + y_rainfall,
        size = rain_fall,
        colour = rain_fall,
        alpha = rain_fall / max(rain_fall, na.rm = T)), 
      shape = 21,
      fill = "cyan") +
    
    # -- scales (stroke around circle)
    scale_color_gradient(low = "transparent", high = "grey25", na.value = NA) +
    
    # -- init new scale
    ggnewscale::new_scale_colour() +
    
    
    # -- cloud -----------------------------------------------------------------

    # -- cloud  
    geom_ribbon(
      aes(
        ymin = y_cloud - cloud_9am / 2,
        ymax = y_cloud + cloud_3pm / 2),
      alpha = 0.3,
      fill = "grey"
      ) +
    
    # -- background line
    geom_hline(
      yintercept = y_cloud,
      color = "beige",
      alpha = 0.25,
      linewidth = 0.25) +
    
    
    # -- sunshine --------------------------------------------------------------
    
    # -- background line
    geom_hline(
      yintercept = y_sunshine,
      color = "beige",
      alpha = 0.25,
      linewidth = 0.25) +
  
    # -- segments
    geom_segment(
      data = observations[observations$sunshine > 0 & !is.na(observations$sunshine), ],
      aes(
        y = y_sunshine,
        yend = -sunshine + y_sunshine,
        color = sunshine,
        alpha = sunshine / max(sunshine, na.rm = T)),
      linewidth = 1) +
      
    # -- points
    geom_point(
      data = observations[observations$sunshine > 0 & !is.na(observations$sunshine), ],
      aes(
        y = -sunshine + y_sunshine, 
        size = sunshine,
        color = sunshine,
        fill = sunshine,
        alpha = sunshine / max(sunshine, na.rm = T) * .25), 
      shape = 21) +
    
    # -- color & fill sclaes
    scale_fill_gradient(low = "transparent", high = "orange") +
    scale_colour_gradient2(low = "grey", mid = "grey25" , high = "orange",
                           midpoint = median(observations$sunshine, na.rm = T)) +
    
    
    # -- Legends ---------------------------------------------------------------
    

  
  
    # -- Axis & Titles ---------------------------------------------------------
    
    # -- Titles
    labs(x = NULL,
         y = NULL) +
    
    # -- Y limits (arbitrary)
    scale_y_continuous(limits = c(0, y_limit)) +
  
      
    # -- Theme -----------------------------------------------------------------
  
    theme(
      
      # -- background
      panel.background = element_blank(),
      plot.background = element_blank(),
      panel.grid = element_blank(),
      
      #panel.background = element_rect(fill = "#2d3037"),
      #plot.background =  element_rect(fill = "#2d3037"),
      
    
      # -- legend
      legend.position = "none",
      
      # -- grid
      panel.grid.minor = element_blank(),
      panel.grid.major = element_blank(),
      
      # -- axis
      axis.text.y = element_blank(),
      axis.ticks.y = element_blank(),
      axis.text = element_text(colour = "grey45")
      
    ) +
    
    # -- make it polar
    coord_polar() +
  
    annotate(geom = 'text', 
             label = '▶', 
             x = max(observations$date), 
             y = y_limit, 
             hjust = 0, 
             vjust = 0,
             color = "grey",
             alpha = .5,
             size = 6)
}

# print(radar(observations_df))
