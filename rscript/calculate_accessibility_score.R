# calculate accessibility score for each hexagon

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


# merge all data together

# replicate what the spreadsheet does

