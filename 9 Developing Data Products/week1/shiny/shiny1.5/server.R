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
     
     output$plot1 <- renderPlot({
          
          set.seed(2016-05-25)
          
          number_of_points <- input$numeric
          
          minX <- input$sliderX[1]
          maxX <- input$sliderX[2]
          
          minY <- input$sliderY[1]
          maxY <- input$sliderY[2]
          
          dataX <- runif(number_of_points, minX, maxX)
          dataY <- runif(number_of_points, minY, maxY)
          
          xlab <- ifelse(test = input$show_xlab, yes = "X axis", no = "")
          ylab <- ifelse(test = input$show_ylab, yes = "Y axis", no = "")
          main <- ifelse(test = input$show_title, yes = "Title", no = "")
          
          plot(dataX, dataY,
               xlab = xlab, ylab = ylab, main = main,
               xlim = c(-100, 100), ylim = c(-100, 100))
          
     })
})
