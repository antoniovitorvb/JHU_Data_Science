library(dplyr)
library(leaflet)

my_map <- leaflet() %>%
     addTiles() %>%
     addCircleMarkers(lat = 39.2980803,
                lng = -76.5898801,
                popup = "Jeff Leek's Office")

my_map
