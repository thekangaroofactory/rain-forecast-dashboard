

# -- load dependencies
library(shiny)
library(bslib)

library(dplyr)
library(magrittr)

library(ggplot2)
library(ggforce)
library(ggnewscale)
library(ggtext)
library(geomtextpath)

library(see)
library(showtext)

# -- debug
DEBUG <- FALSE

# -- init & source code
for(nm in list.files("R", pattern = ".R", full.names = T, recursive = T))
  source(nm)
rm(nm)

