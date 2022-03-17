# Course Project Shiny Application

library(shiny)
library(dplyr)
library(plotly)

shinyUI(fluidPage(

     
     # Application title
     titlePanel("Miles per Gallon per Transmission Type"),
     
     # Sidebar with a slider input for number of bins
     sidebarPanel(
          sliderInput(inputId = "slidermpg",
                      label = "MPG",
                      min = 10,
                      max = 35,
                      value = c(15, 30)),
          
          checkboxInput(inputId = "smooth",
                        label = "Add Regression Line",
                        value = T)
     ),

     # Show a plot of the generated distribution
     mainPanel(
          
          plotlyOutput("plot1"),
          
          # actionButton(inputId = "stop",
          #              label = "Done")
     )
))