# tidy highway analyst data

# columns needed: mode, hex_id, destination_service, travel_time

# generic function to clean HA tables
ha_analyst_clean <- function(df) {
  df %>%
    select(mode = Mode, hex_id = Hex_ID, destination_service = Destination_ID_Type, travel_time = Total_Time_mins) %>%
    filter(!is.na(travel_time)) %>%
    filter(travel_time > 0) %>%
    mutate(destination_service = str_remove(destination_service, "_.*")) %>% 
    mutate(mode = case_when(mode == "Drive" ~ "car",
                            mode == "Walk" ~ "walk",
                            mode == "Cycle" ~ "cycle"))  %>% 
    mutate(destination_service = case_when(destination_service == "Emp500" ~ "Employment500",
                                           destination_service == "Emp5000" ~ "Employment5000",
                                           destination_service == "DistLocalCentre" ~ "DistrictLocalCentre",
                                           TRUE ~ destination_service)
           )
}



# list data frames in environment that begin with "car"
car_tables <- ls(pattern = "^car")
# run ha_analyst_clean function on each "car" data frame
for (i in 1:length(car_tables)) {
  assign(paste0("clean_",car_tables[i]), ha_analyst_clean(get(car_tables[i])))
}

# list data frames in environment that begin with "cycle"
cycle_tables <- ls(pattern = "^cycle")
# run ha_analyst_clean function on each "cycle" data frame
for (i in 1:length(cycle_tables)) {
  assign(paste0("clean_",cycle_tables[i]), ha_analyst_clean(get(cycle_tables[i])))
}

# list data frames in environment that begin with "cycle"
walk_tables <- ls(pattern = "^walk")
# run ha_analyst_clean function on each "cycle" data frame
for (i in 1:length(walk_tables)) {
  assign(paste0("clean_",walk_tables[i]), ha_analyst_clean(get(walk_tables[i])))
}

# rbind all data frames that start with "clean_"
clean_tables <- ls(pattern = "^clean_")
clean_tables <- do.call(rbind, lapply(clean_tables, get))
