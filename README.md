# Toronto Bike Thefts Analysis

## Overview

This repository investigates patterns and predictors of bicycle theft in Toronto using statistical modeling with data from Toronto Police Open Data (2013–present). The analysis explores how factors such as neighborhood, time of day, theft type, and bicycle value influence the likelihood of theft. Using logistic regression, the study identifies significant predictors and provides insights to guide theft prevention strategies. The repository includes data, code, and documentation supporting the analysis and findings.

## Repository Structure

- **data/**
  - `00-simulated_data/`: Contains simulated data used for testing and validation.
    - `simulated_data.csv`
  - `01-raw_data/`: Contains the raw bike theft data.
    - `Bicycle_Thefts_Open_Data.csv`
  - `02-analysis_data/`: Contains cleaned and processed data for analysis.
    - `analysis_data.parquet`

- **models/**: Contains saved model objects in RDS format for the analysis of logistic model.


- **other/**
  - `llm_usage/`: Documentation of interactions with large language models.
    - `usage.txt`
  - `sketches/`: Visual materials related to exploratory data analysis.
    - `dataset.jpg`
    - `EDA.jpg`
    - `output.jpg`

- **paper/**: Files related to the final research paper.
  - `paper.pdf`: The final report.
  - `paper.qmd`: Quarto document used for generating the report.
  - `references.bib`: Bibliography for the report.

- **scripts/**: R scripts used in data simulation, processing, analysis, and modeling.
  - `00-simulate_data.R`: Script for generating simulated data.
  - `01-test_simulated_data.R`: Tests the integrity of simulated data.
  - `02-clean_data.R`: Cleans the raw data for analysis.
  - `03-test_analysis_data.R`: Tests the cleaned data for analysis readiness.
  - `04-exploratory_data_analysis.R`: Performs exploratory data analysis (EDA).
  - `05-model_data.R`: Builds and refines models for analysis.

- `.gitignore`: Lists files and directories ignored by Git.
- `README.md`: This file, providing an overview of the project structure.
- `us_presidential_election_forecast_2024.Rproj`: R project file for the analysis.

## Statement on LLM Usage

Aspects of the code were written with the assistance of ChatGPT-4o. The abstract and introduction were crafted using ChatGPT-4o. The entire chat history is saved in other/llm_usage/usage.txt.