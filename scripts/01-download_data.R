#### Preamble ####
# Purpose: Downloads and saves the data from Open Data Toronto.
# Author: Aviral Bhardwaj
# Date: 2024-09-24
# Contact: aviral.bhardwaj@mail.utoronto.ca
# License: MIT
# Pre-requisites: N.A
# Any other information needed? N.A


#### Workspace setup ####
library(tidyverse)
library(opendatatoronto)
library(readxl)
library(styler)
library(dplyr)

#### Download data ####
# Get package
url <- "https://ckan0.cf.opendata.inter.prod-toronto.ca/dataset/6678e1a6-d25f-4dff-b2b7-aa8f042bc2eb/resource/16a31e1d-b4d9-4cf0-b5b3-2e3937cb4121/download/2023-WardProfiles-2011-2021-CensusData.xlsx"

# load the first datastore resource as a sample
local_file <- tempfile(fileext = ".xlsx")
download.file(url, local_file, mode = "wb")
raw_ward_data <- readxl::read_xlsx(local_file)

# Capital Budgets in Toronto
url <- "https://ckan0.cf.opendata.inter.prod-toronto.ca/dataset/7d3bcf2f-8eca-4ed5-a352-a34adb130931/resource/50f76ab0-3ed3-41b4-8350-49c2c52911f9/download/2023-2032-capital-budget-and-plan-details.xlsx"

# load the first datastore resource as a sample
local_file <- tempfile(fileext = ".xlsx")
download.file(url, local_file, mode = "wb")
raw_capital_data <- readxl::read_xlsx(local_file)

#### Save data ####
write.csv(raw_ward_data, "../data/raw_data/raw_ward_data.csv")
write.csv(raw_capital_data, "../data/raw_data/raw_capital_data.csv")

# clean up
unlink(local_file)