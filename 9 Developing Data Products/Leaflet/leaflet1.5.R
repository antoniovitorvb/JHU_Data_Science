library(dplyr)
library(leaflet)

set.seed(2016-04-25)
df <- data.frame(lat = runif(500, min = 39.25, max = 39.35),
                 lng = runif(500, min = -76.65, max = -76.55))

df %>%
     leaflet() %>%
     addTiles() %>%
     addCircleMarkers(clusterOptions = markerClusterOptions())