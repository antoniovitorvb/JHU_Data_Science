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
     
     titlePanel("Tabs!"),
     sidebarLayout(
          sidebarPanel(
               textInput(inputId = "box1", 
                         label = "Enter Tab 1 Text:", 
                         value = "Tab 1!"),
               
               textInput(inputId = "box2", 
                         label = "Enter Tab 2 Text:", 
                         value = "Tab 2!"),
               
               textInput(inputId = "box3", 
                         label = "Enter Tab 3 Text:", 
                         value = "Tab 3!")
        ),

        # Show a plot of the generated distribution
        mainPanel(
             tabsetPanel(type = "tabs", 
                         tabPanel(title = "Tab 1", br(), textOutput("out1")), 
                         tabPanel(title = "Tab 2", br(), textOutput("out2")), 
                         tabPanel(title = "Tab 3", br(), textOutput("out3"))
             )
        )
     )
))
