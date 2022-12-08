#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(plotly)
library(shinythemes)

# for more stuff on shiny, see chapter 19

# Define UI for application 
source("app_ui.R")

# Define server logic 
source("app_server.R")

# Run the application 
shinyApp(ui = ui, server = server)
