 =============================================================================
# Script: EJ.R
# Purpose: Clean and organise data exported ftom Atlas.ti
# Author: Sindhura
# Date: 24 October 2025
# =============================================================================
# SET UP:
# 1. Load required packages

install.packages("readr")
install.packages("dplyr")
install.packages("tidyr")
install.packages("stringr")
install.packages("readxl")
install.packages("janitor")

library(readxl)
library(readr)     # For reading excel files
library(dplyr)     # For data wrangling
library(tidyr)     # For tidying data
library(stringr)   # For string manipulation
library(janitor)

# 2. Import data

EJ_data <- read_excel("data/raw/EJ and Maritime JET guiding principles.xlsx", sheet = "Code Co-occurrence Table")


# 3. Inspect data
glimpse(EJ_data)
colnames(EJ_data)

# =============================================================================
# PROCESSING:
# 4. Clean data
EJ_data <- clean_names(EJ_data)

EJ_data <- EJ_data %>%
  janitor::clean_names()

print(EJ_data)

#5.Remove empty rows/columns
EJ_data <- EJ_data %>%
  remove_empty(which = c("rows", "cols"))

#6. Remove all the NA from numeric column and make it 0
EJ_data <- EJ_data %>%
  mutate(across(where(is.numeric), ~ replace_na(., 0)))


print(EJ_data)

str(EJ_data)

#7. Renaming Column Name
EJ_data <- EJ_data %>%
  rename(Framework = x1)

print(EJ_data)

#8. Converts the Correlation Matrix data into Table format with 1st column Framework, pivoted columns into new column called Cooccurrence and numeric columns into Frequency
tidy_data <- EJ_data %>%
  pivot_longer(
    cols = -1,  # keep the first column (main code)
    names_to = "Cooccurrence",
    values_to = "Frequency"
  ) %>%
  filter(Frequency > 0)  # keep only meaningful co-occurrences

print(tidy_data)

#9. Remove underscores and capitalize first word
tidy_data <- tidy_data %>%
  mutate(
    Cooccurrence = str_replace_all(Cooccurrence, "_", " "),
    Cooccurrence = str_to_title(Cooccurrence)
  )

print(tidy_data)

#10. Removes bullet point,Gr text and trailing spaces from data
tidy_data_clean <- tidy_data %>%
  mutate(
    Framework = str_replace_all(Framework, "●", ""),            # remove bullet
    Framework = str_replace_all(Framework, "Gr[= ]\\d+", ""),   # remove 'Gr=12' or 'Gr 12'
    Cooccurrence = str_replace_all(Cooccurrence, "Gr[= ]\\d+", ""),
    Framework = str_replace_all(Framework, "\n", " "),          # remove line breaks
    Framework = str_trim(Framework),                            # trim extra spaces
    Cooccurrence = str_trim(Cooccurrence)
  )

print(tidy_data_clean)

#11. writes data into csv file
write.csv(tidy_data_clean, "data/processed/EJ_data.csv", row.names = FALSE)
