library(dplyr)
library(leaflet)

set.seed(2016-04-25)
df <- data.frame(lat = runif(20, min = 39.2, max = 39.3),
                 lng = runif(20, min = -76.6, max = -76.5))

vilaIcon <- makeIcon(
     iconUrl = ""
)

df %>%
     leaflet() %>%
     addTiles() %>%
     addCircleMarkers()