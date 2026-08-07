# ==============================================================================
# Script: 03_models.R
# Purpose: Multiverse Modeling Framework - Marathon Speed (1921-2026)
# Model 1: Naive Normal / Gaussian Distribution (gamlss::NO)
# Model 2: Naive Gaussian Location-Scale Model (gamlss::NO with sigma modeling)
# ==============================================================================

library(here)
library(dplyr)
library(readr)
library(gamlss)

# 1. Load Processed Data -------------------------------------------------------
data_path <- here("data", "01_processed", "marathon_clean.csv")
marathon_df <- read_csv(data_path, show_col_types = FALSE)

# Center year for numerical stability in smoothers/polynomials
marathon_df <- marathon_df %>%
  mutate(year_centered = year - mean(year, na.rm = TRUE))

# Filter historical training set (1921–2025)
train_dat <- marathon_df %>% 
  filter(year <= 2025)

# 2. Model 1: Naive Gaussian (gamlss) ----------------------------------------
# Location parameter (mu) fitted with P-splines on centered year
gamlss1 <- gamlss(
  marathon_speed ~ pb(year_centered),
  family   = NO,
  n.cyc    = 300,
  data     = train_dat
)

# Summary inspection
summary(gamlss1)

# Save Model 1 Object
if (!dir.exists(here("analysis"))) {
  dir.create(here("analysis"))
}
saveRDS(gamlss1, file = here("analysis", "model_1_naive_gaussian.rds"))

# 3. Model 2: Naive Gaussian Location-Scale -----------------------------------
# Location parameter (mu) AND scale parameter (sigma) fitted with P-splines
gamlss2 <- gamlss(
  marathon_speed ~ pb(year_centered),
  sigma.fo       = ~ pb(year_centered),
  family         = NO,
  n.cyc          = 300,
  data           = train_dat
)

# Summary inspection
summary(gamlss2)

# Save Model 2 Object
saveRDS(gamlss2, file = here("analysis", "model_2_gaussian_locationscale.rds"))