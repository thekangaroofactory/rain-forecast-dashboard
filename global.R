

# -- Load dependencies
library(shiny)
library(bslib)
library(dplyr)
library(ggplot2)


# -- function called with pkg::fun
# RCurl
# ggforce
# geomtextpath
# see
# showtext
# ggnewscale

# -- to be removed!? (maybe used in the big data viz with legends & all)
# library(ggtext)


# -- Debug
DEBUG <- Sys.getenv("DEBUG")


# -- Set environment
WS_URL <- Sys.getenv("WS_URL")
WS_BASE_ROUTE <- Sys.getenv("WS_BASE_ROUTE")


# -- Init & source code
for(nm in list.files("R", pattern = ".R", full.names = T, recursive = T))
  source(nm)
rm(nm)


# -- Define global colors
COLORS <- list(bg = "#2d3037",
               fg = "#FFF",
               primary = "orange",
               secondary = "#ececec",
               p_warm = "orange",
               p_cold = "cyan",
               p_mid = "beige")

