# load hexagon grid


# change wd to TAF folder
tryCatch({
  print("Attempting to change working directory to Transport Appraisal Framework…")
  setwd("C:\\Users\\tom.alexander1\\OneDrive - West Of England Combined Authority\\Transport\\7.0 Data\\02 Transport Appraisal Framework")
  print("Success - working directory changed! :D")
},
error=function(cond) {
  print("Attempt unsuccessful. Please navigate to the '02 Transport Appraisal Framework' directory...")
  myFilepath <- choose.dir()  # navigate to TAF folder
  setwd(myFilepath)
  print("Working directory changed! :D")
})

# read in the hex grid
hex <- read_sf("11 Analysis\\7 Visualisation\\shp\\hex_grids\\WECA4_5kmbuffer_Hexagons800m_poly.shp")


