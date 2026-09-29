# Marathon season-best project: reproducible execution entry point
# Run from the marathon-season-best-project RStudio Project.

if (!requireNamespace("here", quietly = TRUE)) {
  stop("The 'here' package is missing. Restore the project with renv first.")
}

project_file <- here::here("marathon-season-best-project.Rproj")
if (!file.exists(project_file)) {
  stop("Open marathon-season-best-project.Rproj before running this script.")
}

raw_file <- here::here("data", "00_raw", "marathon_season_best_1921_2026.sav")
if (!file.exists(raw_file)) stop("Missing raw input: ", raw_file)

message("Step 1/2: preparing data")
source(here::here("R", "02_clean_data.R"), local = new.env(parent = globalenv()))

processed_file <- here::here("data", "01_processed", "marathon_clean.csv")
if (!file.exists(processed_file)) stop("Data preparation did not create: ", processed_file)

message("Step 2/2: fitting models (this may take some time)")
source(
  here::here("R", "03_models.R"),
  local = FALSE
)

expected_models <- here::here("analysis", c(
  "model_1_naive_gaussian.rds",
  "model_2_gaussian_locationscale.rds",
  "model_3_bccg_skewed.rds",
  "model_4_gev_extremes.rds"
))
missing <- expected_models[!file.exists(expected_models)]
if (length(missing)) stop("Missing model output(s): ", paste(missing, collapse = ", "))
message("Completed: processed data and all four model files exist.")
