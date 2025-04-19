

radar <- function(observations, theme = COLORS){
  
  # -- scale values (rainfall values are large compared to temp / sunshine)
  coeff_rainfall <- 10
  
  # -- define y levels
  y_rainfall_legend <- 40
  y_rainfall <- 55
  y_cloud <- 55
  y_sunshine <- 80
  y_seasons <- 90
  y_seasons_text <- 91
  y_limit <- 92
  
  
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
  
    # -- winters & summers text
    geomtextpath::geom_textpath(
      data =   
        # -- check size
        if(nrow(seasons) == 1)
          seasons <- rbind(seasons, data.frame(name = " ",
                                               start = seasons$start + 5,
                                               end = seasons$end))
        else head(seasons, n = 2),
      inherit.aes = FALSE,
      aes(
        x = end - (end - start)/2,
        y = y_seasons_text,
        label = name),
      hjust = 0.5,
      vjust = 1,
      #size = 5,
      color = "grey90",
      alpha = 0.25) +
    
    # -- year separators
    geom_segment(
      data = as.data.frame(year_separators),
      x = as.numeric(year_separators),
      y = 0,
      yend = y_seasons,
      color = "grey45",
      alpha = 0.5) +
    
    # -- start point
    geom_point(
      data = data.frame(x = min(observations$date),
                        y = y_seasons_text),
      aes(
        x = x,
        y = y),
      size = 1,
      color = "grey45") +
    
    # -- start arrow
    # xend is extended by 7.5°
    geom_segment(
      data = data.frame(x = min(observations$date),
                        y = y_seasons_text),
      aes(
        x = x,
        xend = x + as.numeric(max(observations$date) - min(observations$date) + 1) / 360 * 7.5,
        y = y),
      arrow = arrow(angle = 30, length = unit(2.5, "pt")),
      color = "grey45") +
    
    # -- central point
    geom_point(
      data = data.frame(x = min(observations$date),
                        y = 0),
      aes(
        x = x,
        y = y),
      size = 1,
      color = "grey45") +
    
    
    # -- temperatures ----------------------------------------------------------
  
    # -- median temperature
    geom_hline(
      yintercept = median_temp,
      color = theme$p_mid,
      alpha = 0.25,
      linewidth = 0.25) +
    
    # -- temperature (min-max range)
    geom_ribbon(
      aes(
        ymin = min_temp,
        ymax = max_temp),
      fill = theme$p_mid,
      alpha = 0.25) +
    
    # -- min temperature
    geom_line(
      aes(
        y = min_temp,
        colour = min_temp,
        alpha = (median_temp - min_temp) / (median_temp - min(min_temp, na.rm = T))),
      linewidth = 0.25) +
    
    # -- min temperature text
    geom_text(
      data = observations[which.min(observations$min_temp), ],
      aes(
        x = date,
        y = min_temp - 2,
        label = paste(min_temp, "°C")),
      vjust = 0.5,
      size = 3,
      color = theme$p_cold,
      alpha = 0.5) +
    
    # -- max temperature
    geom_line(
      data = observations[!is.na(observations$max_temp), ],
      aes(
        y = max_temp,
        colour = max_temp,
        alpha = (max_temp - median_temp) / (max(max_temp, na.rm = T) - median_temp)),
      linewidth = 0.25) +
    
    # -- max temperature text
    geom_text(
      data = observations[which.max(observations$max_temp), ],
      aes(
        x = date,
        y = max_temp + 2,
        label = paste(max_temp, "°C")),
      vjust = 0.5,
      size = 3,
      color = theme$p_warm,
      alpha = 0.5) +
    
    # -- gradient stroke
    scale_colour_gradient2(low = theme$p_cold, mid = theme$p_mid , high = theme$p_warm,
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
      fill = theme$p_cold) +
    
    # -- max rainfall
    # x gets an additional 15° & fixed y
    geom_text(
      data = observations[which.max(observations$rain_fall), ],
      aes(
        x = date + as.numeric(max(date) - min(date) + 1) / 360 * 15,
        label = paste(rain_fall, "mm")),
      y = y_rainfall_legend,
      vjust = 0.5,
      size = 3,
      color = theme$p_cold,
      alpha = 0.5) +
    
    # -- max rainfall tick
    # x gets an additional 10° & fixed y
    geom_segment(
      data = observations[which.max(observations$rain_fall), ], 
      aes(
        x = date + as.numeric(max(date) - min(date) + 1) / 360 * 10,
        xend = date,
        yend = -rain_fall / coeff_rainfall + y_rainfall),
      y = y_rainfall_legend,
      linewidth = 0.5,
      color = theme$p_cold,
      alpha = 0.25) +
  
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
      color = theme$p_mid,
      alpha = 0.25,
      linewidth = 0.25) +
    
    
    # -- sunshine --------------------------------------------------------------
    
    # -- background line
    geom_hline(
      yintercept = y_sunshine,
      color = theme$p_mid,
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
    
    # -- max sunshine text
    geom_text(
      data = observations[which.max(observations$sunshine), ],
      aes(
        x = date,
        y = -sunshine + y_sunshine - 5,
        label = paste(sunshine, "h")),
      vjust = 0.5,
      size = 3,
      color = theme$p_warm,
      alpha = 0.5) +
    
    # -- color & fill scales
    scale_fill_gradient(low = "transparent", high = theme$p_warm) +
    scale_colour_gradient2(low = "grey", mid = "grey25" , high = theme$p_warm,
                           midpoint = median(observations$sunshine, na.rm = T)) +
  
    
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
    # coord_polar()
    geomtextpath::coord_curvedpolar()
    
}

#print(radar(observations_df))
