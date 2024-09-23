#### Preamble ####
# Purpose: Test data for the project
# Author: Aviral Bhardwaj
# Date: 24 September 2024
# Contact: aviral.bhardwaj@mail.utoronto.ca
# License: MIT
# Pre-requisites: N.A
# Any other information needed? N.A

#### Workspace setup ####
library(tidyverse)

#### Test data ####
capital_data <- read_csv("data/analysis_data/cleaned_capital_data.csv")
ward_data <- read_csv("data/analysis_data/cleaned_ward_data.csv")

# Test data for capital_data
class(capital_data$ward_id) == "numeric"
class(capital_data$ward) == "character"
class(capital_data$category) == "character"
class(capital_data$total_10_year) == "numeric"

# Test capital data ward id is between 1 and 25
capital_data$ward_id %in% 1:25

# Test data for ward_data
class(ward_data$ward_id) == "numeric"
class(ward_data$ward) == "character"
class(ward_data$population) == "numeric"
class(ward_data$average_household_income) == "numeric"

# Test ward data ward id is between 1 and 25
ward_data$ward_id %in% 1:25

# Test ward data population is greater than 0
ward_data$population > 0

# Test ward data average household income is greater than 0
ward_data$average_household_income > 0

# Test ward data average household income is less than 1000000
ward_data$average_household_income < 1000000


# Check that none of the values are NA
sum(is.na(capital_data)) == 0
sum(is.na(ward_data)) == 0

# Check that there are no duplicated rows
sum(duplicated(capital_data)) == 0
sum(duplicated(ward_data)) == 0



