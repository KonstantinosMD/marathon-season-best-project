# ==============================================================================
# Script: 03_models.R
# Purpose: Multiverse Modeling Framework - Marathon Speed (1921-2026)
# ==============================================================================

library(here)
library(dplyr)
library(readr)
library(gamlss)
library(gamlssx)

# 1. Load Processed Data -------------------------------------------------------
data_path <- here("data", "01_processed", "marathon_clean.csv")
marathon_df <- read_csv(data_path, show_col_types = FALSE)

marathon_df <- marathon_df %>%
  mutate(year_centered = year - mean(year, na.rm = TRUE))

train_dat <- marathon_df %>% 
  filter(year <= 2025)

if (!dir.exists(here("analysis"))) {
  dir.create(here("analysis"))
}

# 2. Model 1: Naive Gaussian (Baseline) ----------------------------------------
gamlss1 <- gamlss(
  marathon_speed ~ pb(year_centered),
  family   = NO,
  n.cyc    = 300,
  data     = train_dat
)
saveRDS(gamlss1, file = here("analysis", "model_1_naive_gaussian.rds"))

# 3. Model 2: Gaussian Location-Scale ------------------------------------------
gamlss2 <- gamlss(
  marathon_speed ~ pb(year_centered),
  sigma.fo       = ~ pb(year_centered),
  family         = NO,
  n.cyc          = 300,
  data           = train_dat
)
saveRDS(gamlss2, file = here("analysis", "model_2_gaussian_locationscale.rds"))

# 4. Model 3: Best 3-Parameter Skewed Family (BCCG) ---------------------------
gamlss3 <- gamlss(
  marathon_speed ~ pb(year_centered),
  sigma.fo       = ~ pb(year_centered),
  family         = BCCG,
  n.cyc          = 300,
  data           = train_dat
)
saveRDS(gamlss3, file = here("analysis", "model_3_bccg_skewed.rds"))

# 5. Model 4: Extreme Value Theory (GEV via gamlssx) --------------------------
gamlss4 <- fitGEV(
  marathon_speed ~ pb(year_centered),
  sigma.formula  = ~ pb(year_centered),
  n.cyc          = 300,
  data           = train_dat
)
saveRDS(gamlss4, file = here("analysis", "model_4_gev_extremes.rds"))