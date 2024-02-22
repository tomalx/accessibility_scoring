# calculate accessibility score for each hexagon

# set working directory
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

# load TRACC accessibility data
# for PT mode - PTAll
source("11 Analysis\\7 Visualisation\\accessibility_scoring\\rscript\\load_TRACC_csv.R")

# load baseline data
# for all modes except PT - car, walk and cycle
# data stored in different output compared to TRACC_csv
source("11 Analysis\\7 Visualisation\\accessibility_scoring\\rscript\\load_baseline_walk_car_cycle.R")

# load hexagon data
source("11 Analysis\\7 Visualisation\\accessibility_scoring\\rscript\\load_hex.R")

# tidy highway analyst data: walk, car, cycle


# tidy TRACC data: PTAll


# merge all data together - one table with mode, hex_id, service_destination, travel_time

# replicate what the spreadsheet does

