
# -- 
# This is the user-interface definition of a Shiny web application.
# --

# Define UI for application
page_navbar(
  
  fillable = FALSE,
  footer = p(style = "font-size:9pt;margin-top:20px;", "© 2024 Philippe Peret"),
  
  # -- header / css
  header = tags$link(rel = "stylesheet", type = "text/css", href = "./css/tkf.css"),
  
  # -- theme
  theme = bs_theme(
    bg = "#2d3037",
    fg = "#FFF",
    primary = "orange",
    secondary = "#ececec",
    "theme-colors" = "('flair': orange)",
    base_font = font_google("Quicksand")),
  
  # -- title
  title = "Rain Forecast",
  
  # -- Observations
  nav_panel(title = "Observations",
            
            # -- header boxes
            obs_header_ui("obs"),
            
            # -- summary
            obs_summary_ui("obs"),
            
            # -- select data
            obs_selection_ui("obs"),
            
            # -- plots
            obs_radar_ui("obs"),
            obs_sunshine_ui("obs")),
  
  
  # -- Predictions
  nav_panel(title = "Predictions", 
            
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
            
            # -- project
            h2("About the Project"),
            p("The original dataset is provided by the Australian - Bureau of Meteorology (BOM):", br(),
              tags$a(href = "http://www.bom.gov.au/climate/data/", target = "_blank", "http://www.bom.gov.au/climate/data/"), br(),
              "It contains 140000+ examples, captured between 2008 and 2017 in different locations accross Australia, with daily observations"),
            
            # -- contact  
            h2("Contact"),
            tags$a(href = "https://www.linkedin.com/in/philippeperet/", 
                   target = "_blank",
                   "LinkedIn"),
            
            
            tags$a(href = "https://github.com/thekangaroofactory",
                   target = "_blank",
                   "GitHub"),
            
            tags$a(href = "https://orcid.org/0009-0003-9666-7490",
                   target = "_blank",
                   "ORCID")),
  
)

