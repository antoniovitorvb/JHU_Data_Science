library(shiny)
library(miniUI)

pickTrees <- function(){
     
     ui <- miniPage(
          
          gadgetTitleBar("Select Points by Dragging your Mouse"),
          
          miniContentPanel(
               plotOutput(outputId = "plot1",
                          height = "100%",
                          brush = "brush1")
          )
     )
     
     server <- function(input, output, session){
          
          output$plot1 <- renderPlot({
               plot(x = trees$Girth,
                    y = trees$Volume,
                    main = "Trees!",
                    xlab = "Girth",
                    ylab = "Volume")
          })
          
          observeEvent(eventExpr = input$done, 
                       handlerExpr = {
                            stopApp(brushedPoints(df = trees,
                                                  brush = input$brush1,
                                                  xvar = "Girth",
                                                  yvar = "Volume"))
          })
     }
     
     runGadget(ui, server)
}