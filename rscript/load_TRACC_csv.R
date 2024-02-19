# script to convert outputs of TRACC rus into accessibility metrics


# set wd and load libraries

library(tidyverse)

# use catch error to navigate to correct file path and set as wd
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


# load all accessibility csv outputs into env as data frames
# load all csv files in wd
files <- list.files(path = "13 Connectivity Maps 2023\\TRACC_TAFF2023_CSVfiles\\", 
                    pattern = "*.csv",
                    full.names = TRUE)


for (i in 1:length(files)) {
  df_name <- str_remove(files[i], "13 Connectivity Maps 2023\\\\TRACC_TAFF2023_CSVfiles\\\\")
  df_name <- str_remove(df_name, ".csv")
  df_name <- str_remove(df_name, "WECAplus_TAF_2023_")
  assign(df_name, read.csv(files[i], skip=35, header=TRUE, stringsAsFactors = FALSE))
  rm(df_name, i)
}


for (i in 1:length(files)) {
  df_name <- str_remove(files[i], "13 Connectivity Maps 2023\\\\TRACC_TAFF2023_CSVfiles\\\\")
  df_name <- str_remove(df_name, ".csv")
  df_name <- str_remove(df_name, "WECAplus_TAF_2023_")
  df_name <- paste0("meta_", df_name)
  assign(df_name, read.csv(files[i], skip = 10, nrows = 1, header=FALSE, sep = c(":")) )
  rm(df_name, i)
}
rm(files)


# load spatial data as sf object for west of england hexagons

