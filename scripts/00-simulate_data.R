#### Preamble ####
# Purpose: Simulate data for a fictional scenario
# Author: Aviral Bhardwaj
# Date: 24 September 2024
# Contact: aviral.bhardwaj@mail.utoronto.ca
# License: MIT
# Pre-requisites: N.A
# Any other information needed? N.A


#### Workspace setup ####
# Load required library
library(tibble)
library(ggplot2)

# Set seed for reproducibility
set.seed(1008239407)

# Parameters
wards <- 25
categories <- c('A', 'B', 'C')

# Simulate data
ward_id <- rep(1:wards, each = length(categories))  # Ward IDs from 1 to 25
category <- rep(categories, times = wards)  # Categories A, B, C for each ward
population <- sample(80000:120000, size = wards * length(categories), replace = TRUE)  # Population 80k to 120k
income <- sample(60000:200000, size = wards * length(categories), replace = TRUE)  # Income 60k to 200k
budget_allocation <- sample(10000:100000, size = wards * length(categories), replace = TRUE)  # Budget 10k to 100k

# Create tibble (data frame)
df <- tibble(
  ward_id = ward_id,
  category = category,
  population = population,
  income = income,
  budget_allocation = budget_allocation
)

# Convert each column to its appropriate data type
df$ward_id <- as.integer(df$ward_id)
df$category <- as.factor(df$category)
df$population <- as.integer(df$population)
df$income <- as.integer(df$income)
df$budget_allocation <- as.integer(df$budget_allocation)

# Plot 1: Income vs Budget Allocation with smooth line for each category
plot_income_vs_budget <- ggplot(df, aes(x = income, y = budget_allocation, color = category)) +
  geom_point() +  # Dot plot
  geom_smooth(method = "loess", se = FALSE) +  # Smooth fit line
  labs(title = "Income vs Budget Allocation by Category",
       x = "Income",
       y = "Budget Allocation") +
  theme_minimal()

# Plot 2: Population vs Budget Allocation with smooth line for each category
plot_population_vs_budget <- ggplot(df, aes(x = population, y = budget_allocation, color = category)) +
  geom_point() +  # Dot plot
  geom_smooth(method = "loess", se = FALSE) +  # Smooth fit line
  labs(title = "Population vs Budget Allocation by Category",
       x = "Population",
       y = "Budget Allocation") +
  theme_minimal()


