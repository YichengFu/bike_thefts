#### Preamble ####
# Purpose: Test the analysis data to check for potential problems with cleaning. 
# Author: Tommy Fu
# Date: 27 November 2024
# Contact: tommy.fu@mail.utoronto.ca
# Pre-requisites: 
# - The `tidyverse` package must be installed and loaded
# - 02-clean_data.R must have been run

#### Workspace setup ####
library(tidyverse)
library(testthat)
library(arrow) # For reading Parquet files

data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

#### Test data ####
# Test that the dataset has no missing values
test_that("no missing values in dataset", {
  expect_true(all(!is.na(data)))
})

# Test that 'occurence_date' and 'report_date' are of Date type
test_that("'occurence_date' and 'report_date' are Date type", {
  expect_s3_class(data$occurence_date, "Date")
  expect_s3_class(data$report_date, "Date")
})

# Test that 'BIKE_COST' is numeric
test_that("'BIKE_COST' and 'BIKE_SPEED' are numeric", {
  expect_type(data$BIKE_COST, "double")
})

# Test that 'STATUS' and 'BIKE_MAKE' are character
test_that("'STATUS' and 'BIKE_MAKE' are character", {
  expect_type(data$STATUS, "character")
  expect_type(data$BIKE_MAKE, "character")
})

# Test that 'BIKE_COST' has a positive median value
test_that("'BIKE_COST' has a positive median value", {
  expect_true(median(data$BIKE_COST, na.rm = TRUE) > 0)
})

# Test that there are no duplicate rows
test_that("no duplicate rows in the dataset", {
  expect_equal(nrow(data), nrow(distinct(data)))
})

# Test that 'STATUS' contains only valid values
valid_status <- c("STOLEN", "LOST")
test_that("'STATUS' contains only valid values", {
  expect_true(all(data$STATUS %in% valid_status))
})