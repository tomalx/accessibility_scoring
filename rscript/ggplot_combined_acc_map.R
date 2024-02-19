# set wd
setwd("C:/Users/tom.alexander1/OneDrive - West Of England Combined Authority/Transport/7.0 Data/02 Transport Appraisal Framework/11 Analysis/7 Visualisation/")




if(!require(plotly)) install.packages("plotly")
if(!require(sf)) install.packages("sf")
if(!require(mapboxer)) install.packages("mapboxer")
if(!require(leaflet)) install.packages("leaflet")

# load libraries
library(plotly)
library(sf)
library(tidyverse)
library(mapboxer)
library(leaflet)

# read in the shp file from combined scores data folder
combined_acc_scores <- read_sf("shp/combined_scores/TAF_s4a_Scenario4_v3_CombinedHeatmap_Scores.shp")

# read in text file with mapbox token
mapbox_token <- read_file("txt/mapbox_token.txt")
Sys.setenv("MAPBOX_TOKEN" = mapbox_token)


# plot ggplot map using Total_noCar variable in combined_acc_scores

choropleth_map <- 
  ggplot(combined_acc_scores) +
  geom_sf(aes(fill = Total_noCa), alpha = 0.5) +
  scale_fill_viridis_c() +
  theme_void() +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5)) +
  labs(title = "West of England Accessibility Scores")

choropleth_map <- ggplotly(choropleth_map)


mapbox_choropleth_map <- choropleth_map %>% 
  layout(
    mapbox = list(
      style = "carto-positron",
      zoom = 10,
      center = list(lon = -2.5, lat = 51.5)
    )
  )

mapbox_choropleth_map

choropleth_map <- choropleth_map %>% 
  config(mapboxAccessToken = mapbox_token)

choropleth_map



static_choropleth_map <- 
  ggplot(combined_acc_scores) +
  geom_sf(aes(fill = Total_noCa), alpha = 0.5) +
  scale_fill_viridis_c() +
  theme_void() +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5)) +
  labs(title = "West of England Accessibility Scores")

ggplotly(static_choropleth_map)


# create mapbox map
# using mapbox token
# using mapbox style "light"
# with no legend

interactive_choropleth_map <- 
  ggplot(combined_acc_scores) +
  geom_sf(aes(fill = Total_noCa), alpha = 0.5) +
  scale_fill_viridis_c() +
  theme_void() +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5)) +
  labs(title = "West of England Accessibility Scores") +
  mapboxer::mapbox_token(mapbox_token) +
  mapbox::mapbox_style("light")

map <- mapboxer(
  center = c(-73.9165, 40.7114),
  zoom = 10,
  minZoom = 6,
  pitch = 30,
  bearing = 45
)
map


# convert combined_acc_scores to WGS84 geometry
combined_acc_scores_wgs84 <- st_transform(combined_acc_scores, crs = 4326)

# pal <- leaflet::colorNumeric(
#   "YlOrRd",
#   domain = combined_acc_scores_wgs84$Total_noCa
# )

pal <-  colorNumeric(
    palette = "viridis",
    domain = combined_acc_scores_wgs84$Total_noCa)


# create leaflet map of accessibility scores
leaflet(combined_acc_scores_wgs84) %>%
  addProviderTiles(providers$CartoDB.Voyager) %>% 
  # add polygons coloured by Total_noCa
  addPolygons(
    fillColor = ~pal(Total_noCa),
    fillOpacity = 0.7,
    weight = 0.5,
    color = "white",
    opacity = 1,
    # highlight = highlightOptions(
    #   weight = 5,
    #   color = "#666",
    #   dashArray = "",
    #   fillOpacity = 0.7,
    #   bringToFront = TRUE),
    label = ~Total_noCa)

previewColors(colorNumeric("viridis", domain = log(combined_acc_scores_wgs84$accs_score +1)), 
              combined_acc_scores_wgs84$accs_score + 1)


log(combined_acc_scores_wgs84$accs_score + 1)

pal <- colorNumeric("viridis", domain = 0:100)
previewColors(~pal(runif(10, 60, 100)))

