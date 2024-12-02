#### Preamble ####
# Purpose: Built Models for logistic regression model to predict thefts in high-risk neighborhoods.
# Author: Tommy Fu
# Date: 27 November 2024
# Contact: tommy.fu@mail.utoronto.ca
# Pre-requisites: 
# - All the necessary packages must be installed and loaded 'dplyr','tidyr','arrow','lubridate','tidyverse',testthat'.
# - 02-clean_data.R must have been run
# - 03-test_analysis_data must have been run and passed
# - 04-exploratory_data_analysis.R must have been run

#### Workspace setup ####
library(tidyverse)
library(rstanarm)


#### Read data ####
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

# ensure outcome consistency by setting seed
set.seed(432)

# get the reduced dataset of only 1000 randomly selected data entries
data_reduced <- 
  analysis_data |> 
  slice_sample(n = 1000)

#### Logistic Regression Model ####
bike_theft_risk_model <- stan_glm(
  formula = is_high_risk_neighborhood ~ BIKE_COST + PREMISES_TYPE + LOCATION_TYPE + OCC_HOUR,
  data = data_reduced,
  family = binomial(link = "logit"),
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
  prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
  seed = 853
)

#### Save model ####
saveRDS(bike_theft_risk_model,file = "models/bike_theft_risk_model.rds")
