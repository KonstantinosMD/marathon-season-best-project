# Marathon Season-Best Analysis (1921–2026)

## Project Overview
This repository is a practical side project designed to implement and master **Christopher Gandrud's Reproducible Research Framework** using RStudio, R Markdown/Quarto, and Git version control.

The empirical focus of the project is modeling annual season-best marathon performances (1921–2026). Specifically, it evaluates 2026 (held-out year) sub-2-hour exceedance probabilities using continuous marathon speed across four statistical models:
1. **Naive Gaussian**
2. **Location-Scale**
3. **3-Parameter Distribution (e.g., BCCG via GAMLSS)**
4. **Generalized Extreme Value (GEV)**

## Inferential Setup
To test parameter vs. sampling uncertainty, predictions for 2026 are generated across an 8-multiverse matrix:
* **4 Models** $\times$ **2 Bootstrap Frameworks** (Parametric vs. Non-Parametric) + Simulation

## Project Structure
Follows Gandrud's modular directory setup using `here()` for absolute-relative file paths:

```text
├── data/
│   ├── 00_raw/         # Raw SPSS dataset (.sav)
│   └── 01_processed/   # Cleaned export (.csv)
├── R/                  # Modular execution scripts
│   ├── 01_import_data.R
│   └── 02_clean_data.R
├── README.md
└── marathon-season-best-project.Rproj