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
    titlePanel("HTML Tags"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            h1("H1 Text"),
            h2("H2 text"),
            h3("H3 Text"),
            em("Emphasized Text")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h3("Main Panel Text"),
            code("Some code!")
        )
    )
))
