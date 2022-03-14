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

    # Application title
    titlePanel("Plot Random Numbers"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
             numericInput(inputId = "numeric",
                          label = "How Many Random Numbers Should Be Plotted?",
                          value = 1000, min = 1, max = 1000, step = 1),
             
             sliderInput(inputId = "sliderX",
                         label = "Pick Minimun and Maximun X Values",
                         min = -100, max = 100, value = c(-50, 50)),
             
             sliderInput(inputId = "sliderY",
                         label = "Pick Minimun and Maximun Y Values",
                         min = -100, max = 100, value = c(-50, 50)),
             
             checkboxInput(inputId = "show_xlab",
                           label = "Show/Hide X Axis Label",
                           value = T),
             
             checkboxInput(inputId = "show_ylab",
                           label = "Show/Hide Y Axis Label",
                           value = T),
             
             checkboxInput(inputId = "show_title",
                           label = "Show/Hide Title",
                           value = T)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h3("Graph of Random Points"),
            
            plotOutput("plot1")
        )
    )
))
