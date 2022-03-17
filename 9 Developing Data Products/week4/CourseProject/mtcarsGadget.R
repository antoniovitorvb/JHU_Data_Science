library(shiny)
library(miniUI)
library(dplyr)
library(plotly)

data(mtcars)

mtcars <- mtcars %>%
     mutate(am = factor(am,
                        labels = c("Automatic", "Manual")))

mtcarsGadget <- function(){
     
     ui <- miniPage(
          gadgetTitleBar("Miles per Gallon per Transmission Type"),
          
          miniContentPanel(
               sliderInput(inputId = "slidermpg",
                           label = "MPG",
                           min = 10,
                           max = 35,
                           value = c(15, 30)),
               
               checkboxInput(inputId = "smooth",
                             label = "Add Regression Line",
                             value = T)
          ),
          
          miniContentPanel(
               plotlyOutput(outputId = "plot1")
          )
     )
     
     server <- function(input, output, session){
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
               
               p <- ggplotly(gg)
               p
          })
          
          observeEvent(eventExpr = input$done, {
               stopApp()
          })
     }
     
     runGadget(ui, server)
}