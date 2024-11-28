#### Preamble ####
# Purpose: Cleans the raw bike thefts data, adds high-risk neighborhood variable, and saves the cleaned data.
# Author: Tommy Fu
# Date: 27 November 2024
# Contact: tommy.fu@mail.utoronto.ca
# Pre-requisites: 
# - All the necessary packages must be installed and loaded: 'dplyr', 'tidyr', 'arrow', 'lubridate'.
# - 00-simulate_data.R and 01-test_simulated_data.R must have been run.

#### Workspace setup ####
# Load necessary libraries
library(tidyverse)
library(arrow)
library(lubridate) # For date handling

#### Clean data ####
# Load the raw dataset
bicycle_thefts <- read_csv("data/01-raw_data/Bicycle_Thefts_Open_Data.csv")

# Clean the dataset
bicycle_thefts_cleaned <- bicycle_thefts %>%
  # Remove observations where STATUS is "UNKNOWN" or "RECOVERED"
  filter(!STATUS %in% c("UNKNOWN", "RECOVERED")) %>%
  # Drop the BIKE_MODEL, BIKE_SPEED, and BIKE_COLOUR columns due to a high proportion of missing values
  select(-BIKE_MODEL, -BIKE_SPEED, -BIKE_COLOUR) %>%
  # Drop rows with missing values in BIKE_MAKE and BIKE_COST
  filter(!is.na(BIKE_MAKE), !is.na(BIKE_COST)) %>%
  # Convert OCC_DATE and REPORT_DATE to Date format
  mutate(
    occurence_date = as_date(OCC_DATE, format = "%m/%d/%Y %I:%M:%S %p"),
    report_date = as_date(REPORT_DATE, format = "%m/%d/%Y %I:%M:%S %p")
  )

#### Identify High-Risk Neighborhoods ####
# Count thefts by neighborhood
top_neighborhoods <- bicycle_thefts_cleaned %>%
  count(NEIGHBOURHOOD_140, sort = TRUE) %>%
  slice_max(n, n = 10) %>% # Adjust 'n' for the number of high-risk neighborhoods
  pull(NEIGHBOURHOOD_140)

#### Add is_high_risk_neighborhood Variable ####
bicycle_thefts_cleaned <- bicycle_thefts_cleaned %>%
  mutate(is_high_risk_neighborhood = ifelse(NEIGHBOURHOOD_140 %in% top_neighborhoods, 1, 0))

#### Check the Updated Dataset ####
glimpse(bicycle_thefts_cleaned)

# Save the cleaned dataset as a Parquet file
write_parquet(bicycle_thefts_cleaned, "data/02-analysis_data/analysis_data.parquet")
