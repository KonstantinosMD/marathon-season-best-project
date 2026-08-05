library(here)
library(haven)

# Import raw SPSS dataset
raw_sav_path <- here("data", "00_raw", "marathon_season_best_1921_2026.sav")
raw_data <- read_sav(raw_sav_path)