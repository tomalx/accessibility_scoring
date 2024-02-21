# load baseline data

if(!require(readxl)) install.packages("readxl")

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

## path to excel workbook
path_to_walk_output <- "11 Analysis\\TRACC Outputs\\default\\Combined_Output_Nearest_20_Walk_Services.xlsx"
path_to_car_output <- "11 Analysis\\TRACC Outputs\\default\\Combined_Output_Nearest_20_Drive_Services.xlsx"
path_to_cycle_output <- "11 Analysis\\TRACC Outputs\\default\\Combined_Output_Nearest_20_Cycle_Services.xlsx"

# need to load in every sheet from the excel workbook as separate data frames
# load xls data from \\11 Analysis\\TRACC Outputs\\Baseline_v1_Car
# function to load all sheets

# ## function to test if file is currently open - return TRUE if open, FALSE if not
# file.opened <- function(path) {
#       suppressWarnings(
#         "try-error" %in% class(
#           try(file(path, 
#                    open = "w"), 
#               silent = TRUE
#           )
#         )
#       )
# }

#file.opened(path_to_highway_analyst_output)

# # if file is open print error message
# if (file.opened(path_to_highway_analyst_output)) {
#   print("Excel workbook is currently open. Please close the file and try again.")
# } else {
#   print("File is not currently open. Proceeding to load data...")
# }


# ### function to read all sheets in specified file path and return as list of tibbles
# read_all_sheets <- function(path = path_to_highway_analyst_output) {
#   # get all sheet names
#   sheets <- readxl::excel_sheets(path)
#   # read all sheets into a list
#   lapply(sheets, function(x) readxl::read_excel(path, sheet = x))
# }

### function to read all sheets in specified file path and assign to separate tibbles in global environment
read_all_sheets <- function(path) {
  # get all sheet names
  sheets <- readxl::excel_sheets(path)
  # iterate through sheet names and assign to separate tibbles in global environment
  for (i in 1:length(sheets)) {
    assign(sheets[i], readxl::read_excel(path, sheet = sheets[i]))
  }
}


sheets <- excel_sheets(path = path_to_cycle_output)
for (i in 1:length(sheets)) {
  assign(paste0("cycle_",sheets[i]), readxl::read_excel(path_to_cycle_output, sheet = sheets[i]))
}

sheets <- excel_sheets(path = path_to_walk_output)
for (i in 1:length(sheets)) {
  assign(paste0("walk_",sheets[i]), readxl::read_excel(path_to_walk_output, sheet = sheets[i]))
}

sheets <- excel_sheets(path = path_to_car_output)
for (i in 1:length(sheets)) {
  assign(paste0("car_",sheets[i]), readxl::read_excel(path_to_car_output, sheet = sheets[i]))
}
