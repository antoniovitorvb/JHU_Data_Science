library(plotly)
library(dplyr)
library(tidyr)

data("diamonds")
d <- diamonds[sample(nrow(diamonds), 10000),]
gg <- ggplot(d,
             aes(x = carat,
                 y = price)) +
     geom_point() +
     geom_smooth(aes(colour = cut,
                     fill = cut)) +
     facet_wrap(~ cut)
gg

p <- ggplotly(gg)
p