#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

     titlePanel("Visualize Many Models"),
     
     sidebarLayout(
          sidebarPanel(
               h3("Slope"),
               textOutput("slopeOut"),
               
               h3("Intercept"),
               textOutput("intOut")
          ),
          
          mainPanel(
               plotOutput("plot1", 
                          brush = brushOpts(id = "brush1")
               )
          )
     )
))