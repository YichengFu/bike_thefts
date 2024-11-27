#### Preamble ####
# Purpose: Perform Exploratory Data Analysis (EDA) on bike thefts data to explore the data structure and interesting patterns. 
# Author: Tommy Fu
# Date: 27 November 2024
# Contact: tommy.fu@mail.utoronto.ca
# Pre-requisites: 
# - All the necessary packages must be installed and loaded 'dplyr','tidyr','arrow','lubridate','tidyverse',testthat'.
# - 02-clean_data.R must have been run
# - 03-test_analysis_data must have been run and passed


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(lubridate)

#### Read data ####
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

#### Data structure and summary ####
# Overview of the dataset
glimpse(analysis_data)

# Summary statistics
summary(analysis_data)

#### Patterns and Trends ####
# Theft counts over time
theft_trends <- analysis_data %>%
  mutate(year_month = floor_date(occurence_date, "month")) %>%
  count(year_month) %>%
  arrange(year_month)

# Plot theft trends over time
ggplot(theft_trends, aes(x = year_month, y = n)) +
  geom_line() +
  labs(
    title = "Monthly Bike Thefts in Toronto",
    x = "Date",
    y = "Number of Thefts"
  ) +
  theme_minimal()

# Theft counts by neighbourhood
theft_by_neighbourhood <- analysis_data %>%
  count(NEIGHBOURHOOD_140, sort = TRUE)

# Top 10 neighbourhoods with the most thefts
top_neighbourhoods <- theft_by_neighbourhood %>%
  slice_max(n, n = 10)

# Plot top 10 neighbourhoods
ggplot(top_neighbourhoods, aes(x = reorder(NEIGHBOURHOOD_140, n), y = n)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(
    title = "Top 10 Neighbourhoods with Most Bike Thefts",
    x = "Neighbourhood",
    y = "Number of Thefts"
  ) +
  theme_minimal()

#### Visualization of Bike Cost ####

# Create bins for better interpretability
analysis_data <- analysis_data %>%
  mutate(bike_cost_bin = cut(
    BIKE_COST,
    breaks = seq(0, max(BIKE_COST, na.rm = TRUE), by = 500),
    include.lowest = TRUE,
    labels = paste0("$", seq(0, max(BIKE_COST, na.rm = TRUE), by = 500)[-1])
  ))

# Plot bike cost distribution using bins
ggplot(analysis_data, aes(x = bike_cost_bin)) +
  geom_bar(fill = "blue", alpha = 0.7) +
  labs(
    title = "Distribution of Bike Costs",
    x = "Bike Cost (Binned)",
    y = "Frequency"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#### Location and Premises Analysis ####
# Theft counts by location type
location_analysis <- analysis_data %>%
  count(LOCATION_TYPE, sort = TRUE)

# Plot theft counts by location type
ggplot(location_analysis, aes(x = reorder(LOCATION_TYPE, n), y = n)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(
    title = "Theft Counts by Location Type",
    x = "Location Type",
    y = "Number of Thefts"
  ) +
  theme_minimal()

# Theft counts by premises type
premises_analysis <- analysis_data %>%
  count(PREMISES_TYPE, sort = TRUE)

# Plot theft counts by premises type
ggplot(premises_analysis, aes(x = reorder(PREMISES_TYPE, n), y = n)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(
    title = "Theft Counts by Premises Type",
    x = "Premises Type",
    y = "Number of Thefts"
  ) +
  theme_minimal()