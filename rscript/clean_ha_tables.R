# tidy highway analyst data

# columns needed: mode, hex_id, destination_service, travel_time

# generic function to clean HA tables
ha_analyst_clean <- function(df) {
  df %>%
    select(mode = Mode, hex_id = Hex_ID, destination_service = Destination_ID_Type, travel_time = Total_Time_mins) %>%
    filter(!is.na(travel_time)) %>%
    filter(travel_time > 0) %>%
    # remove characters including and after "_" in string
    mutate(destination_service = str_remove(destination_service, "_.*")) %>% 
    mutate(destination_service = case_when(destination_service == "Emp500" ~ "Employment500"))
    }

car_Employment500_clean <- ha_analyst_clean(`car_Emplyment500+`)

car_CityCentre_clean <- car_CityCentre %>%
  select(mode = Mode, hex_id = Hex_ID, destination_service = Destination_ID_Type, travel_time = Total_Time_mins) %>%
  filter(!is.na(travel_time)) %>%
  filter(travel_time > 0)

# list data frames in environment that begin with "car"
car_tables <- ls(pattern = "^car")
