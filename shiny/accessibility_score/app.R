#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(leaflet)
library(sf)
library(RColorBrewer)

# set wd
setwd("C:/Users/tom.alexander1/OneDrive - West Of England Combined Authority/Transport/7.0 Data/02 Transport Appraisal Framework/11 Analysis/7 Visualisation/")

# read in the shp file from combined scores data folder
combined_acc_scores <- read_sf("shp/combined_scores/TAF_s4a_Scenario4_v3_CombinedHeatmap_Scores.shp")
# convert combined_acc_scores to WGS84 geometry
combined_acc_scores_wgs84 <- st_transform(combined_acc_scores, crs = 4326)
# create new variable to store the combined accessibility scores
combined_acc_scores_wgs84$accs_score <- 
  combined_acc_scores_wgs84$Walk + combined_acc_scores_wgs84$Cycle + combined_acc_scores_wgs84$All_PT + combined_acc_scores_wgs84$Car
# recalculate the accessibility score if the value is greater than 0
#combined_acc_scores_wgs84$accs_score[combined_acc_scores_wgs84$accs_score > 1] <- 
#  log(combined_acc_scores_wgs84$accs_score)

#view accs_score variable
#combined_acc_scores_wgs84$accs_score

pal <-  
  colorQuantile(
    palette = "viridis",
    domain = 5*combined_acc_scores_wgs84$accs_score,
    n=10)


# Define UI for application that draws a leaflet webmap
ui <- fillPage(

    # Application title
    titlePanel("West of England Accessibility Scores"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("walk",
                        "walk weighting:",
                        min = 0,
                        max = 10,
                        value = 1),
            sliderInput("cycle",
                        "cycle weighting:",
                        min = 0,
                        max = 10,
                        value = 1),
            sliderInput("pt",
                        "public transport weighting:",
                        min = 0,
                        max = 10,
                        value = 1),
            sliderInput("car",
                        "car weighting:",
                        min = 0,
                        max = 10,
                        value = 1)
        ),

        # Show a leaflet map
        mainPanel(
            leafletOutput("map", height = "100vh")
        )
    )
)

# Define server logic required to a leaflet map
server <- function(input, output) {
  
    observe({
      # create a reactive variable to store the combined accessibility scores
      combined_acc_scores_wgs84$accs_score <- 
        input$walk * combined_acc_scores_wgs84$Walk +
        input$cycle * combined_acc_scores_wgs84$Cycle +
        input$pt * combined_acc_scores_wgs84$All_PT +
        input$car * combined_acc_scores_wgs84$Car
    })

    output$map <- renderLeaflet({
      
      # create a reactive variable to store the combined accessibility scores
      # combined_acc_scores_wgs84$accs_score <- 
      #     input$walk * combined_acc_scores_wgs84$Walk +
      #     input$cycle * combined_acc_scores_wgs84$Cycle +
      #     input$pt * combined_acc_scores_wgs84$All_PT +
      #     input$car * combined_acc_scores_wgs84$Car
    
        
      
      # create a reactive variable to store the colour palette
      # pal <-  
      #     colorNumeric(
      #     palette = "viridis",
      #     domain = combined_acc_scores_wgs84$accs_score)
      # 
        
      
      leaflet(combined_acc_scores_wgs84) %>%
        #mutate(accs_score = log(accs_score+1)) %>%
        addProviderTiles(providers$CartoDB.Voyager) %>% 
        # add polygons coloured by Total_noCa
        addPolygons(
          fillColor = ~pal(accs_score),
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
          label = ~accs_score)
       
      
      
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
