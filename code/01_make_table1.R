# Rscript to make Table 1

library(labelled)
library(gtsummary)

# Load in data

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

breast_cancer |>
  select("status", "grade_revised", "a_stage", "estrogen_status", "progesterone_status", "tumor_size", "age") |>
  tbl_summary(by = status) |>
  modify_spanning_header(c("stat_1", "stat_2") ~ "**Survival Status**") |>
  modify_caption("**Breast Cancer Patient Characteristics**") |>
  bold_labels() |>  
  add_overall() |>
  add_p()

