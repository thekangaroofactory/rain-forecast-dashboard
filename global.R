

# -- Load dependencies
library(shiny)
library(bslib)
library(dplyr)
library(ggplot2)


# -- function called with pkg::fun
# library(ggforce)
# library(geomtextpath)
# library(see)
# library(showtext)


# -- to be removed!? (maybe used in the big data viz with legends & all)
# library(ggnewscale)
# library(ggtext)


# -- Debug
DEBUG <- FALSE


# -- Set environment
WS_URL <- Sys.getenv("WS_URL")
WS_BASE_ROUTE <- Sys.getenv("WS_BASE_ROUTE")


# -- Init & source code
for(nm in list.files("R", pattern = ".R", full.names = T, recursive = T))
  source(nm)
rm(nm)

