# Rscript for data cleaning

library(here)
library(janitor)
here::i_am("code/00_clean_data.R")
absolute_path_to_data <- here::here("data/Breast_Cancer.csv")
breast_cancer <- read.csv(absolute_path_to_data, header=TRUE) |>
  clean_names()


# Check for missing data
table(breast_cancer$status, useNA="ifany")
table(breast_cancer$grade, useNA="ifany")
table(breast_cancer$a_stage, useNA="ifany")
table(breast_cancer$estrogen_status, useNA="ifany")
table(breast_cancer$progesterone_status, useNA="ifany")
fivenum(breast_cancer$age)
fivenum(breast_cancer$tumor_size)


# Save cleaned data to the data folder
saveRDS(
  breast_cancer,
  file = here::here("data", "breast_cancer.rds")
)


