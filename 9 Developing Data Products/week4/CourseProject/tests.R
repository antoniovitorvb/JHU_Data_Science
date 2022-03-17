library(plotly)
library(dplyr)
library(tidyr)

data(mtcars)

mtcars <- mtcars %>%
     mutate(am = factor(am,
                        labels = c("Automatic", "Manual")))


gg <- ggplot(mtcars,
             aes(x = wt,
                 y = mpg,
                 color = am)) +
     geom_point() +
     geom_smooth(method = "lm") +
     labs(x = "Weight (1000 lbs)",
          y = "MPG",
          color = "Transmission Type")

p <- ggplotly(gg)
p