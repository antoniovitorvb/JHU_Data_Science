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
     
     titlePanel("Predict Horsepower from MPG"),
     sidebarLayout(
          sidebarPanel(
               sliderInput(inputId = "sliderMPG", 
                           label = "What is the MPG of the car?", 
                           min = 10, max = 35, value = 20),
               
               checkboxInput(inputId = "showModel1", 
                             label = "Show/Hide Model 1", 
                             value = TRUE),
               
               checkboxInput(inputId = "showModel2", 
                             label = "Show/Hide Model 2", 
                             value = TRUE),
               
               # the app will only react to the parameter changes if this button is pressed
               submitButton("Submit")
               
          ),
          
          # Show a plot of the generated distribution
          mainPanel(
               plotOutput("plot1"),
               
               h3("Predicted Horsepower from Model 1:"),
               textOutput("pred1"),
               
               h3("Predicted Horsepower from Model 2:"),
               textOutput("pred2")
          )
     )
))

