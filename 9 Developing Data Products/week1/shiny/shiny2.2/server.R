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

     mtcars$mpgsp <- ifelse(test = mtcars$mpg - 20 > 0, 
                            yes = mtcars$mpg - 20, no = 0)
     
     model1 <- lm(hp ~ mpg, data = mtcars)
     model2 <- lm(hp ~ mpgsp + mpg, data = mtcars)
     
     model1pred <- reactive({
          
          mpgInput <- input$sliderMPG
          
          predict(model1, newdata = data.frame(mpg = mpgInput))
     })
     
     model2pred <- reactive({
          
          mpgInput <- input$sliderMPG
          
          predict(model2, 
                  newdata = data.frame(mpg = mpgInput,
                                       mpgsp = ifelse(test = mpgInput - 20 > 0,
                                                      yes = mpgInput - 20, 
                                                      no = 0)))
     })
     
     output$plot1 <- renderPlot({
          
          mpgInput <- input$sliderMPG
          
          plot(x = mtcars$mpg, 
               y = mtcars$hp, 
               
               xlab = "Miles Per Gallon", 
               ylab = "Horsepower", bty = "n", pch = 16,
               xlim = c(10, 35), ylim = c(50, 350))
          
          if(input$showModel1){
               abline(model1, col = "red", lwd = 2)
          }
          
          if(input$showModel2){
               model2lines <- predict(model2, 
                                      newdata = data.frame(mpg = 10:35, 
                                                           mpgsp = ifelse(test = 10:35 - 20 > 0, 
                                                                          yes = 10:35 - 20, no = 0)
               ))
               lines(10:35, model2lines, col = "blue", lwd = 2)
          }
          
          legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), 
                 pch = 16, col = c("red", "blue"), bty = "n", cex = 1.2)
          
          points(mpgInput, model1pred(), col = "red", pch = 16, cex = 2)
          points(mpgInput, model2pred(), col = "blue", pch = 16, cex = 2)
     })
     
     output$pred1 <- renderText({
          model1pred()
     })
     
     output$pred2 <- renderText({
          model2pred()
     })

})