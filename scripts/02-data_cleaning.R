#### Preamble ####
# Purpose: Cleans the raw ward profile and ward capital budget data
# Author: Aviral Bhardwaj
# Date: 2024-09-24
# Contact: aviral.bhardwaj@mail.utoronto.ca
# License: MIT
# Pre-requisites: N.A
# Any other information needed? N.A

#### Workspace setup ####
library(tidyverse)
library(readxl)
library(styler)
library(dplyr)
library(arrow)

#### Clean data ####

raw_data_1 <- read_csv("../data/raw_data/raw_ward_data.csv")

# Only keep the relevant columns:
cleaned_ward_data <-
  raw_data_1[c(18, 997, 1307, 1383), ]

cleaned_ward_data <- as.data.frame(t(cleaned_ward_data)) |>
  slice(-1) |>
  slice(-1) |>
  rename(population = V1, income = V4)

# Remove the first row:
cleaned_ward_data <- cleaned_ward_data[-1, ]

# Add ward_id column:
cleaned_ward_data$ward_id = 1:25

# Set row name as ward_id
rownames(cleaned_ward_data) <- cleaned_ward_data$ward_id

ward_names <- c("Etobicoke North", "Etobicoke Centre", "Etobicoke-Lakeshore", 
                "Parkdale-High Park","York South-Weston", "York Centre", 
                "Humber River-Black Creek", "Eglinton-Lawrence",
                "Davenport", "Spadina-Fort York", "University-Rosedale",
                "Toronto-St. Paul's", "Toronto Centre", "Toronto-Danforth",
                "Don Valley West", "Don Valley East", "Don Valley North",
                "Willowdale", "Beaches-East York", "Scarborough Southwest",
                "Scarborough Centre", "Scarborough-Agincourt",
                "Scarborough North", "Scarborough-Guildwood",
                "Scarborough-Rouge Park")

# Add ward name column:
cleaned_ward_data$ward = ward_names

# Calculate the percentage of uneducated people in each ward:
cleaned_ward_data <- cleaned_ward_data[c("ward_id", "ward", "population", "income")] |>
  rename("average_household_income" = "income")

raw_capital_data_2 <- read_csv("../data/raw_data/raw_capital_data.csv")

# Only keep the relevant columns with name Total 10 Year, Ward Number, Ward, Category
cleaned_capital_data <- raw_capital_data_2[c(15, 16, 17, 18)] |>
  rename("ward_id" = "Ward Number") |>
  rename("ward" = "Ward") |>
  rename("category" = "Category") |>
  rename("total_10_year" = "Total 10 Year")

# Filter out the rows in ward_id that are CW (city wide) as they are not relevant
cleaned_capital_data <- cleaned_capital_data %>%
  filter(ward_id != "CW")

# Combine the rows with the same ward_id and category and sum the total_10_year keep the ward_name
cleaned_capital_data <- cleaned_capital_data |>
  group_by(ward_id, ward, category) |>
  summarise(total_10_year = sum(total_10_year)) |>
  mutate(ward_id = as.numeric(ward_id)) |>
  arrange(ward_id)

#### Save data ####
write.csv(cleaned_ward_data, "../data/analysis_data/cleaned_ward_data.csv")
write.csv(cleaned_capital_data, "../data/analysis_data/cleaned_capital_data.csv")
write_parquet(cleaned_ward_data, "../data/analysis_data/cleaned_ward_data.parquet")
write_parquet(cleaned_capital_data, "../data/analysis_data/cleaned_capital_data.parquet")


