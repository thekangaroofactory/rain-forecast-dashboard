
# -- 
# This is the user-interface definition of a Shiny web application.
# --

library(shiny)
library(bslib)

# Define UI for application
page_navbar(
  
  # -- include css
  # tags$head(
  #   tags$link(rel = "stylesheet", type = "text/css", href = "./css/tkf.css")),
  
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
  
  # -- portfolio
  nav_panel(title = "Observations", 
            
            fluidRow(
              obs_header_ui("obs")),
            
            p(" "),
            
            fluidRow(
              obs_summary_ui("obs")),
            
            fluidRow(
              obs_selection_ui("obs")),
            
            p(" "),
            
            fluidRow(
              obs_radar_ui("obs")),
            
            fluidRow(
              obs_sunshine_ui("obs")),
            
            p(class = "footer", "qksjqksjld")),
  
  
  # -- profile
  # insert ui & outputs + backend server logic (module)
  nav_panel(title = "Predictions", 
            
            fluidRow(
              pre_header_ui("pre")),
            
            pre_selection_ui("pre"),
            
            ),
  
  
  # -- contact
  nav_panel(title = "About", 
            
            card(
              
              # -- header
              card_header(h2("About the Project")),
              
              # -- body
              card_body(
                "The original dataset is provided by the Australian - Bureau of Meteorology (BOM):", br(),
                tags$a(href = "http://www.bom.gov.au/climate/data/", target = "_blank", "http://www.bom.gov.au/climate/data/"),
                "It contains 140000+ examples, captured between 2008 and 2017 in different locations accross Australia, with daily observations")),
              
            card(

              # -- header
              card_header(h2("Contact")),
              
              card_body(
                
                tags$a(href = "https://www.linkedin.com/in/philippeperet/", 
                       target = "_blank",
                       "LinkedIn"),
                
                
                tags$a(href = "https://github.com/thekangaroofactory",
                       target = "_blank",
                       "GitHub"),
                
                tags$a(href = "https://orcid.org/0009-0003-9666-7490",
                       target = "_blank",
                       "ORCID"))))
  
)

