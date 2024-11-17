# Rscript to make regression primary model

library(labelled)
library(gtsummary)

# Load in data

binary_mod <- glm(
  status_numeric ~ grade_revised + a_stage + estrogen_status + progesterone_status + tumor_size + age,
  data = breast_cancer,
  family = binomial()
)

tbl_regression(binary_mod, exponentiate = TRUE) |>
  modify_caption("**Logistic Regression for Breast Cancer Survival**") |>
  bold_labels() |>  
  add_global_p()