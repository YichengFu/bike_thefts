#### Preamble ####
# Purpose: Simulates a dataset of bike thefts, including all the variables of interests.
# Author: Tommy Fu
# Date: 26 November 2024
# Contact: tommy.fu@mail.utoronto.ca
# Pre-requisites: The `tidyverse` package must be installed

#### Workspace setup ####
library(tidyverse)
set.seed(432)

#### Simulate data ####
# Neighborhood names (sample from Toronto or customize further)
neighborhoods <- c(
  "Downtown Toronto",
  "Scarborough",
  "North York",
  "Etobicoke",
  "East York",
  "York",
  "West End"
)

# Theft types
theft_types <- c("Locked", "Unlocked", "Partially Secured")

# Simulate dataset
simulated_data <- tibble(
  incident_id = 1:500,  # Simulate 500 incidents
  neighborhood = sample(
    neighborhoods,
    size = 500,
    replace = TRUE,
    prob = c(0.3, 0.2, 0.2, 0.1, 0.1, 0.05, 0.05) # Distribution across neighborhoods
  ),
  theft_type = sample(
    theft_types,
    size = 500,
    replace = TRUE,
    prob = c(0.6, 0.3, 0.1) # Distribution of theft types
  ),
  day_of_week = sample(
    c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"),
    size = 500,
    replace = TRUE
  ),
  time_of_day = sample(
    c("Morning", "Afternoon", "Evening", "Night"),
    size = 500,
    replace = TRUE,
    prob = c(0.2, 0.3, 0.4, 0.1) # Theft more common in the evening
  ),
  bike_value = round(runif(500, min = 100, max = 3000), 2), # Random bike values in dollars
  reported_to_police = sample(
    c(TRUE, FALSE),
    size = 500,
    replace = TRUE,
    prob = c(0.7, 0.3) # Reporting likelihood
  )
)

# save the simulated data
write.csv(simulated_data,"data/00-simulated_data/simulated_data.csv")
