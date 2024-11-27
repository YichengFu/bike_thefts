#### Preamble ####
# Purpose: Tests the structure and validity of the simulated bike thefts data. 
# Author: Tommy Fu
# Date: 27 November 2024
# Contact: tommy.fu@mail.utoronto.ca
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run


#### Workspace setup ####
library(tidyverse)

# Load simulated data
simulated_data <- tibble(
  incident_id = 1:500,  # Simulate 500 incidents
  neighborhood = sample(
    c("Downtown Toronto", "Scarborough", "North York", "Etobicoke", 
      "East York", "York", "West End"),
    size = 500,
    replace = TRUE
  ),
  theft_type = sample(
    c("Locked", "Unlocked", "Partially Secured"),
    size = 500,
    replace = TRUE
  ),
  day_of_week = sample(
    c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", 
      "Saturday", "Sunday"),
    size = 500,
    replace = TRUE
  ),
  time_of_day = sample(
    c("Morning", "Afternoon", "Evening", "Night"),
    size = 500,
    replace = TRUE
  ),
  bike_value = round(runif(500, min = 100, max = 3000), 2),  # Random bike values
  reported_to_police = sample(
    c(TRUE, FALSE),
    size = 500,
    replace = TRUE
  )
)

# Test if the dataset was successfully created
if (exists("simulated_data")) {
  message("Test Passed: The dataset was successfully created.")
} else {
  stop("Test Failed: The dataset could not be created.")
}

#### Test data ####

# Check if the dataset has 500 rows
if (nrow(simulated_data) == 500) {
  message("Test Passed: The dataset has 500 rows.")
} else {
  stop("Test Failed: The dataset does not have 500 rows.")
}

# Check if the dataset has 7 columns
if (ncol(simulated_data) == 7) {
  message("Test Passed: The dataset has 7 columns.")
} else {
  stop("Test Failed: The dataset does not have 7 columns.")
}

# Check if all values in the 'incident_id' column are unique
if (n_distinct(simulated_data$incident_id) == nrow(simulated_data)) {
  message("Test Passed: All values in 'incident_id' are unique.")
} else {
  stop("Test Failed: The 'incident_id' column contains duplicate values.")
}

# Check if the 'neighborhood' column contains only valid neighborhood names
valid_neighborhoods <- c(
  "Downtown Toronto", "Scarborough", "North York", "Etobicoke", 
  "East York", "York", "West End"
)

if (all(simulated_data$neighborhood %in% valid_neighborhoods)) {
  message("Test Passed: The 'neighborhood' column contains only valid neighborhood names.")
} else {
  stop("Test Failed: The 'neighborhood' column contains invalid neighborhood names.")
}

# Check if the 'theft_type' column contains only valid theft types
valid_theft_types <- c("Locked", "Unlocked", "Partially Secured")

if (all(simulated_data$theft_type %in% valid_theft_types)) {
  message("Test Passed: The 'theft_type' column contains only valid theft types.")
} else {
  stop("Test Failed: The 'theft_type' column contains invalid theft types.")
}

# Check if there are any missing values in the dataset
if (all(!is.na(simulated_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Check if the 'bike_value' column contains only numeric values greater than 0
if (all(simulated_data$bike_value > 0)) {
  message("Test Passed: All 'bike_value' values are greater than 0.")
} else {
  stop("Test Failed: Some 'bike_value' values are not greater than 0.")
}

# Check if the 'reported_to_police' column contains only TRUE or FALSE
if (all(simulated_data$reported_to_police %in% c(TRUE, FALSE))) {
  message("Test Passed: The 'reported_to_police' column contains only TRUE or FALSE.")
} else {
  stop("Test Failed: The 'reported_to_police' column contains invalid values.")
}

# Check if the 'time_of_day' column has at least two unique values
if (n_distinct(simulated_data$time_of_day) >= 2) {
  message("Test Passed: The 'time_of_day' column contains at least two unique values.")
} else {
  stop("Test Failed: The 'time_of_day' column contains less than two unique values.")
}

# Check if all 'day_of_week' values are valid weekdays
valid_days <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")

if (all(simulated_data$day_of_week %in% valid_days)) {
  message("Test Passed: The 'day_of_week' column contains only valid weekday names.")
} else {
  stop("Test Failed: The 'day_of_week' column contains invalid weekday names.")
}

#### Summary ####
message("All tests completed.")