# calculate accessibility score for each hexagon

# load TRACC accessibility data
# for PT mode - PTAll
source("11 Analysis\\7 Visualisation\\rscript\\load_TRACC_csv.R")

# load baseline data
# for all modes except PT - car, walk and cycle
# data stored in different output compared to TRACC_csv
source("11 Analysis\\7 Visualisation\\rscript\\load_baseline.R")

# load hexagon data
source("11 Analysis\\7 Visualisation\\rscript\\load_hex.R")

# replicate what the spreadsheet does

# ask Rob where the csv outputs for the other modes are kept