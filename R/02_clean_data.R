# ==============================================================================
# Script: 02_clean_data.R
# Purpose: Finalize factor definitions and types for marathon modeling
# ==============================================================================

library(here)
library(haven)
library(dplyr)
library(readr)

# 1. Load Raw Data -------------------------------------------------------------
raw_data <- read_sav(here("data", "00_raw", "marathon_season_best_1921_2026.sav"))

# 2. Variable Typing & Cleaning ------------------------------------------------
clean_data <- raw_data %>%
  zap_labels() %>% 
  mutate(
    # Continuous Variables & Integer
    racetime       = as.numeric(racetime),
    marathon_speed = as.numeric(marathon_speed),
    year           = as.integer(year),
    
    # Categorical Variables (Factors)
    athleteid      = as.factor(athleteid),
    nationid       = as.factor(nationid),
    venueid        = as.factor(venueid),
    marathon_era   = as.factor(marathon_era),
    performance    = as.factor(performance)
  )

# 3. Export Processed Data (Gandrud Standard) ----------------------------------
write_csv(clean_data, here("data", "01_processed", "marathon_clean.csv"))