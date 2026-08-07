# Marathon Season-Best Analysis (1921–2026)

## Project Overview
This repository is a practical side project designed to implement and master **Christopher Gandrud's Reproducible Research Framework** using RStudio, R Markdown/Quarto, and Git version control.

The empirical focus of the project is modeling annual season-best marathon performances (1921–2026). Specifically, it evaluates 2026 (held-out year) sub-2-hour exceedance probabilities using continuous marathon speed across four distinct candidate models.

---

## Multiverse Model Specifications

To evaluate performance trends, we implement a 4-model GAMLSS candidate multiverse progression. Each model systematically relaxes distributional assumptions:

| Model ID | Family / Distribution | Formula | Target Modeling Assumption |
| :--- | :--- | :--- | :--- |
| **Model 1** | Gaussian (`NO`) | $\mu = f(\text{year})$ | Baseline (Symmetric, Fixed Variance) |
| **Model 2** | Gaussian Location-Scale (`NO`) | $\mu, \sigma = f(\text{year})$ | Heteroscedasticity (Dynamic Variance Over Time) |
| **Model 3** | Box-Cox Cole & Green (`BCCG`) | $\mu, \sigma = f(\text{year}), \nu = \text{const}$ | Continuous Skewness ($\mu, \sigma, \nu$) |
| **Model 4** | Generalized Extreme Value (`GEV`) | $\mu, \sigma = f(\text{year}), \xi = \text{const}$ | Extreme Value Tail Limits / Block Maxima |

### Parameter Key
* **$\mu$ (Location):** Central tendency (median/mean speed) smoothed across years via P-splines (`pb()`).
* **$\sigma$ (Scale):** Dispersion / coefficient of variation across annual performative spread.
* **$\nu$ / $\xi$ (Shape):** Skewness transformation parameter (`BCCG`) or extreme value shape parameter (`GEV`).

---

## Inferential Setup
To test parameter vs. sampling uncertainty, predictions for 2026 are generated across an 8-multiverse matrix:
* **4 Models** $\times$ **2 Bootstrap Frameworks** (Parametric vs. Non-Parametric) + Simulation

---

## Project Structure
Follows Gandrud's modular directory setup using `here()` for absolute-relative file paths:

```text
├── analysis/           # Saved fitted model objects (.rds)
├── data/
│   ├── 00_raw/         # Raw SPSS dataset (.sav)
│   └── 01_processed/   # Cleaned export (.csv)
├── figures/            # Output diagnostic and prediction plots
├── tables/             # Output model comparison tables
├── R/                  # Modular execution scripts
│   ├── 01_import_data.R
│   ├── 02_clean_data.R
│   └── 03_models.R
├── README.md
└── marathon-season-best-project.Rproj