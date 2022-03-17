# Course Project Shiny Application

library(shiny)
library(dplyr)
library(plotly)

data(mtcars)

mtcars <- mtcars %>%
     mutate(am = factor(am,
                        labels = c("Automatic", "Manual")))

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

     output$plot1 <- renderPlotly({
          
          MPGslider <- input$slidermpg
          
          mtcars_sub <- mtcars %>%
               subset(between(mpg, MPGslider[1], MPGslider[2]))
          
          gg <- ggplot(data = mtcars_sub,
                      aes(x = wt,
                          y = mpg,
                          color = am)) +
               geom_point() +
               labs(x = "Weight (1000 lbs)",
                    y = "MPG",
                    color = "Transmission Type")
          
          if (input$smooth) {
               gg <- gg + geom_smooth(method = "lm")
          }
               
          p<- ggplotly(gg)
          p
     })
     
     observeEvent(input$stop, {
          stopApp()
     })
})