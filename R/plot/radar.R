

radar <- function(observations){
  
  coeff_rainfall <- 10
  
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
      color = "grey45") +
    
    
    # -- temperatures ----------------------------------------------------------
  
    # -- median temperature
    geom_hline(
      yintercept = median_temp,
      color = "beige",
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
        alpha = median_temp - min_temp),
      linewidth = 0.25) +
    
    # -- max temperature
    geom_line(
      aes(
        y = max_temp,
        colour = max_temp,
        alpha = max_temp - median_temp),
      linewidth = 0.25) +
    
    # -- gradient stroke
    scale_colour_gradient2(low = "cyan", mid = "beige" , high = "orange",
                           midpoint = median(c(observations$min_temp, observations$max_temp), na.rm = T)) +
    
    # -- init new scale
    ggnewscale::new_scale_colour() +
    
    
    # -- rainfall --------------------------------------------------------------
    
    # -- rainfall
    geom_point(
      aes(
        y = -rain_fall / coeff_rainfall + y_rainfall,
        size = rain_fall,
        colour = rain_fall,
        alpha = rain_fall / max(rain_fall, na.rm = T)), 
      shape = 21,
      fill = "cyan") +
    
    
    # -- cloud -----------------------------------------------------------------

    # -- cloud  
    geom_ribbon(
      aes(
        ymin = y_cloud - cloud_9am / 2,
        ymax = y_cloud + cloud_3pm / 2),
      alpha = 0.3,
      fill = "grey"
      ) +
    
    
    # -- sunshine --------------------------------------------------------------
    
    # -- segments
    geom_segment(
      aes(
        y = y_sunshine,
        yend = -sunshine + y_sunshine,
        alpha = sunshine / max(sunshine, na.rm = T) / 10),
      colour = "orange") +
      
    # -- points
    geom_point(aes(y = -sunshine + y_sunshine, 
                   size = sunshine,
                   shape = shp, 
                   fill = sunshine,
                   alpha = sunshine / max(sunshine, na.rm = T)), 
               shape = 21,
               color = "#2d3037") +
    
    # -- Scales ----------------------------------------------------------------
  
    # -- color & fill gradients
    scale_color_gradient(low = "#2d3037", high = "cyan", na.value = NA) +
    scale_fill_gradient(low = "#2d3037", high = "orange") +
    
    
    # -- axis titles
    labs(x = NULL,
         y = NULL) +
    
    # -- axis ticks
    scale_y_continuous(limits = c(0, y_limit)) +
    
    # -- theme
    theme(
      
      # -- background
      #panel.background = element_blank(),
      #plot.background = element_blank(),
      panel.grid = element_blank(),
      
      panel.background = element_rect(fill = "#2d3037"),
      plot.background =  element_rect(fill = "#2d3037"),
      
    
      # -- legend
      legend.position = "none",
      
      # -- grid
      panel.grid.minor = element_blank(),
      panel.grid.major = element_blank(),
      
      # -- axis
      axis.text.y = element_blank(),
      axis.ticks.y = element_blank(),
      axis.text = element_text(colour = "grey45")
      
    )
    
    #coord_polar()
  
}

print(radar(observations_df))
