

library(readr)
library(dplyr)

# formated_data <- read_csv("data/formated_data.csv")

formated_data$month <- factor(format(formated_data$Date, "%m"))

# -- build stats (to order)
stats <- formated_data %>%
  group_by(month) %>%
  summarise(cumsum = sum(Sunshine, na.rm = TRUE),
            mean = mean(Sunshine, na.rm = TRUE),
            median = median(Sunshine, na.rm = TRUE)) %>%
  arrange(., -median) %>%
  mutate(name = month.name[month])

# -- get max sunshine
maxday <- formated_data[!is.na(formated_data$Sunshine) & formated_data$Sunshine == max(formated_data$Sunshine, na.rm = T), ]
maxvalue <- unique(maxday$Sunshine)
maxmonth <- names(which.max(table(maxday$month)))
rm(maxday)

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

names(color_palette) <- rev(stats$month)

# Add Google Font (e.g., Roboto)
font_add_google(name = "Lexend")


library(ggplot2)
library(see)
library(ggtext)
library(showtext)


sunshine <- function(data, family = ""){

  # -- enable custom fonts
  showtext_auto()
  
  # -- init
  ggplot(data,
         aes(x = month,
             y = Sunshine,
             fill = month)) +
    
    # -- vertical lines
    # otherwise they won't be in the background
    geom_hline(
      yintercept = c(5, 10),
      linetype = "dotted",
      alpha = 0.2) +
    
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
      size = 8,
      alpha = 0.2) +
    
    # -- Legend: sunshine
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
      size = 4.5,
      alpha = 0.35) +
    
    # -- Legend: max sunshine
    geom_text(
      data = data.frame(month = maxmonth,
                        Sunshine = maxvalue),
      aes(x = month,
          y = Sunshine,
          label = paste0(round(Sunshine, digits = 1), "h\nmax")),
      hjust = 0,
      vjust = 0,
      nudge_x = -0.6,
      family = family,
      fontface = "plain",
      size = 3.5,
      lineheight = 0.75,
      alpha = 0.35) +
    
    # -- title
    geom_textbox(
      data = data.frame(
        x = stats$month[1],
        y = -8,
        label = "<b style='font-size:30pt'>Sunshine in</b><br>
        <b style='font-size:72pt;color:#fe8d5b;'>Sydney</b><br>
        <p style='font-size:10pt;'>Data visualization by Philippe Peret.</p>",
        month = "06"),
      aes(x = x,
          y = y,
          label = label),
      hjust = 0,
      vjust = 1,
      width = unit(200, "points"),
      family = family,
      size = 4,
      box.colour = NA,
      fill = NA) +
    
    # -- description
    geom_textbox(
      data = data.frame(
        x = stats$month[7],
        y = -8,
        label = "<p style='font-size:14pt;'>Daily distribution<br><span style='font-size:9pt;'>(hours per day)</span></p>
        <p style='font-size:10pt;'>Horizontal lines show the range of values<br>
        Out of all observations<br>
        - 50% are inside the boxes<br>
        - 50% are on each sides of the vertical lines (median)<br>
        - 25% are above or below the limits of the boxes<br></p>
        <p style='font-size:10pt;'>Shadows display the distribution of values<br>
        along the range</p>",
        month = "06"),
      aes(x = x,
          y = y,
          label = label),
      hjust = 0,
      vjust = 0.5,
      width = unit(275, "points"),
      family = family,
      size = 4,
      box.colour = NA,
      fill = NA) +
    
    # -- dataset
    geom_textbox(
      data = data.frame(
        x = stats$month[12],
        y = -8,
        label = paste0("<i style='font-size:9pt;color:grey40;'>Source: BOM<br>
        The dataset contains", nrow(formated_data), " observations<br>
                       (from ", min(formated_data$Date), " to ", max(formated_data$Date), ")</i>"),
        month = "06"),
      aes(x = x,
          y = y,
          label = label),
      hjust = 0,
      vjust = 0.5,
      width = unit(250, "points"),
      family = family,
      box.colour = NA,
      fill = NA) +
    
    # -- reorder month
    scale_x_discrete(limits = rev(stats$month)) +
    scale_y_continuous(limits = c(-8, NA),
                       breaks = c(0, 5, 10),) +
    
    # -- colors
    scale_fill_manual(values = color_palette) +
    
    # -- make horizontal
    coord_flip() +
    
    # -- theme
    theme(
      
      plot.margin = margin(t = 20,
                           b = 10),
      
      legend.position = "none",
      
      axis.title.y = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks.y = element_blank(),
      axis.title.x = element_blank(),
      axis.text.x = element_text(family = family),
      
      panel.background = element_blank(),
      plot.background = element_rect(fill = "#F8EAD3"),
      
      #f7e6ca
      
      panel.grid = element_blank()
      
      )
  
}
