#### Preamble ####
# Purpose: Build a logistic regression model to predict thefts in high-risk neighborhoods with improved predictor transformations.
# Author: Tommy Fu
# Date: 27 November 2024
# Contact: tommy.fu@mail.utoronto.ca
# Pre-requisites: 
# - All the necessary packages must be installed and loaded: 'dplyr', 'tidyr', 'arrow', 'lubridate', 'tidyverse', 'rstanarm'.
# - 02-clean_data.R must have been run
# - 03-test_analysis_data must have been run and passed
# - 04-exploratory_data_analysis.R must have been run

#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(lubridate)
library(arrow)

#### Read data ####
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

# Transform predictors for improved model performance
analysis_data <- analysis_data %>%
  # Log-transform BIKE_COST to handle skewness
  mutate(log_bike_cost = log1p(BIKE_COST)) %>%
  # Categorize OCC_HOUR into broader time-of-day groups
  mutate(time_of_day = case_when(
    OCC_HOUR >= 6 & OCC_HOUR < 12 ~ "Morning",
    OCC_HOUR >= 12 & OCC_HOUR < 18 ~ "Afternoon",
    OCC_HOUR >= 18 & OCC_HOUR < 24 ~ "Evening",
    TRUE ~ "Night"
  ))

# Ensure consistent outcome by setting a seed
set.seed(432)

# Sample a subset of data for faster model fitting
data_reduced <- analysis_data %>% 
  slice_sample(n = 1000)

#### Logistic Regression Model ####
bike_theft_risk_model <- stan_glm(
  formula = is_high_risk_neighborhood ~ log_bike_cost + PREMISES_TYPE + time_of_day,
  data = data_reduced,
  family = binomial(link = "logit"),
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
  prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
  seed = 853
)

#### Save model ####
saveRDS(bike_theft_risk_model, file = "models/bike_theft_risk_model.rds")
