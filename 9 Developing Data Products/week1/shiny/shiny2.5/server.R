#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

     output$out1 <- renderText(input$box1)
     output$out2 <- renderText(input$box2)
     output$out3 <- renderText(input$box3)

})