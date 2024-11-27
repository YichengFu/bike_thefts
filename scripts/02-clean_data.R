#### Preamble ####
# Purpose: Cleans the raw bike thefts data and drop observations that are missing importatn variables. 
# Author: Tommy Fu
# Date: 27 November 2024
# Contact: tommy.fu@mail.utoronto.ca
# Pre-requisites: 
# - All the necessary packages must be installed and loaded
# - 00-simulate_data.R and 01-test_simulated_data.R must have been run

#### Workspace setup ####
# Load necessary libraries
library(dplyr)
library(tidyr)
library(arrow)
library(lubridate) # For date handling

#### Clean data ####
# Load the raw dataset
bicycle_thefts <- read_csv("data/01-raw_data/Bicycle_Thefts_Open_Data.csv")

# Clean the dataset
bicycle_thefts_cleaned <- bicycle_thefts %>%
  # Remove observations where STATUS is "UNKNOWN" or "RECOVERED"
  filter(!STATUS %in% c("UNKNOWN", "RECOVERED")) %>%
  # Drop the BIKE_MODEL, BIKE_SPEED and BIKE_COLOUR column due to a high proportion of missing values
  select(-BIKE_MODEL, -BIKE_SPEED, -BIKE_COLOUR) %>%
  # Drop rows with missing values in BIKE_MAKE and BIKE_COST
  filter(!is.na(BIKE_MAKE), !is.na(BIKE_COST)) %>%
  # Convert OCC_DATE and REPORT_DATE to Date format
  mutate(
    occurence_date = as_date(OCC_DATE, format = "%m/%d/%Y %I:%M:%S %p"),
    report_date = as_date(REPORT_DATE, format = "%m/%d/%Y %I:%M:%S %p")
  )

# Save the cleaned dataset as a Parquet file
write_parquet(bicycle_thefts_cleaned, "data/02-analysis_data/analysis_data.parquet")
