library('tidyverse')
library('ggplot2')
library('leaflet')
library('leaflet.extras')

ggplot() +
  geom_point(data = snow_deaths, aes(x = long, y = lat), color = 'blue', shape = 16) +
  geom_point(data = snow_pumps, aes(x = long, y = lat), color = 'black', shape = 17, size = 3)

m2 <- leaflet(data = snow_deaths) |>
  setView(lng = -0.136, lat = 51.513, zoom = 16) |>
  addProviderTiles(providers$CartoDB.Positron)
m2
m2 |> addHeatmap(lng = ~long, lat = ~lat, 
                 intensity = ~Count, blur = 40, max = 1, radius = 25) |>
  addMarkers(data = snow_pumps, ~long, ~lat, group = "Pumps") |>
  addMarkers(data = snow_deaths, ~long, ~lat,
             clusterOptions = markerClusterOptions, group = "Deaths")
