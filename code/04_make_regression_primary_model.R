# Rscript to make regression primary model

library(forcats)
library(labelled)
library(gtsummary)
library(dplyr)

# Load in data
here::i_am("code/04_make_regression_primary_model.R")

breast_cancer <- readRDS(
  file = here::here("data/breast_cancer.rds")
)

breast_cancer$status_numeric <- ifelse(breast_cancer$status == "Alive", 0, 1)

breast_cancer <- breast_cancer |>
  mutate(grade = fct_relevel(as.factor(grade), c("1", "2", "3", " anaplastic; Grade IV"))) |>
  mutate(a_stage = fct_relevel(as.factor(a_stage), c("Regional", "Distant")))

breast_cancer$grade_revised <- gsub(" anaplastic; Grade IV", "4", breast_cancer$grade)

var_label(breast_cancer) <- list(
  age = "Age (years)",
  a_stage = "Cancer Stage",
  grade_revised = "Cancer Grade",
  estrogen_status = "Estrogen Status",
  progesterone_status = "Progesterone Status",
  status = "Survival Status",
  tumor_size = "Tumor Size (mm)"
)

binary_mod <- glm(
  status_numeric ~ grade_revised + a_stage + estrogen_status + progesterone_status + tumor_size + age,
  data = breast_cancer,
  family = binomial()
)

regression_model <- tbl_regression(binary_mod, exponentiate = TRUE) |>
  modify_caption("**Logistic Regression for Breast Cancer Survival**") |>
  bold_labels() |>  
  add_global_p()


saveRDS(
  regression_model,
  file = here::here("output", "regression_model.rds")
)