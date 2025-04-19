
# -- 
# This is the user-interface definition of a Shiny web application.
# --

# Define UI for application
page_navbar(
  
  fillable = FALSE,
  footer = p(style = "font-size:9pt;margin-top:20px;", "© 2025 Philippe Peret"),
  
  # -- header / css
  header = tags$link(rel = "stylesheet", type = "text/css", href = "./css/rain_forecast.css"),
  
  # -- theme
  theme = bs_theme(
    bg = COLORS$bg,
    fg = COLORS$fg,
    primary = COLORS$primary,
    secondary = COLORS$secondary,
    base_font = font_google("Quicksand")),
  
  # -- title
  title = "Rain Forecast",
  
  # -- Observations
  nav_panel(title = "Observations",
            class = "p-5",
            
            # -- header boxes
            obs_header_ui("obs"),
            
            # -- summary
            obs_summary_ui("obs"),
            
            # -- select data
            obs_selection_ui("obs"),
            
            # -- radar section
            obs_radar_ui("obs"),
            
            # -- rain section
            obs_rain_section_ui("obs"),
            obs_rainfall_ui("obs"),
            
            # -- sunshine section
            obs_sun_section_ui("obs"),
            obs_sunshine_ui("obs")),
  
  
  # -- Predictions
  nav_panel(title = "Predictions", 
            class = "p-5",
            
            # -- header boxes
            pre_header_ui("pre"),
            
            # -- summary
            pre_summary_ui("pre"),
            
            # -- select data
            pre_selection_ui("pre"),
            
            # -- plots
            pre_accuracy_ui("pre"),
            pre_confusion_ui("pre"),
            pre_kpis_ui("pre"),
            pre_distribution_ui("pre")),
  
  
  # -- Models
  # nav_panel(title = "Models", 
  #           
  #           fluidRow(
  #             h2("Models performances goes here")),
  #           
  #           fluidRow(
  #             p("créer un comparatif des différents models PR / ROC"))),
  
  
  # -- About
  nav_panel(title = "About", 
            class = "p-5",
            
            # -- project
            h2("Data source"),
            p("The dataset used to train the prediction model is provided by the Australian - Bureau of Meteorology (BOM):", br(),
              tags$a(href = "http://www.bom.gov.au/climate/data/", target = "_blank", "http://www.bom.gov.au/climate/data/"), br(),
              "It contains 140.000+ examples, captured between 2008 and 2017 in different locations accross Australia, with daily observations"),
            p("The daily observations used to assess the model performance and predict rain for the next day are collected from the same data source."),
            
            # -- code
            div(class = "section",
                h2("Code"),
                p("The code for this dashboard is available in the following GitHub repository:"),
                tags$a(href = "https://github.com/thekangaroofactory/rain-forecast-dashboard",
                       target = "_blank",
                       "rain-forecast-dashboard")),
            
            # -- contact
            div(class = "section",
                h2("Contact"),
                p("This web application has been developped with ❤ by Philippe PERET."),
                tags$a(href = "https://www.linkedin.com/in/philippeperet/", 
                       target = "_blank",
                       "LinkedIn")))
  
)
