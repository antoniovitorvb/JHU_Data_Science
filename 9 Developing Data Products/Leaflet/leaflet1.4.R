library(dplyr)
library(leaflet)

ssa <- data.frame(lat = rnorm(50, mean = -12.971111, sd = 0.02),
                 lng = rnorm(50, mean = -38.450833, sd = 0.015))

vilaIcon <- makeIcon(
     iconUrl = "https://raw.githubusercontent.com/antoniovitorvb/JHU_Data_Science/main/9%20Developing%20Data%20Products/Leaflet/vila-icon.png",
     iconWidth = 45*215/230, iconHeight = 45,
     iconAnchorX = 45*215/230, iconAnchorY = 45
)

vilaSite <- "<a href = 'http://www.vilabaloes.com.br'>Vila Baloes</a>"

ssa %>%
     leaflet() %>%
     addTiles() %>%
     addMarkers(icon = vilaIcon,
                popup = vilaSite)
