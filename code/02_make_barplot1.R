# Rscript to create barplot 1

library(ggplot2)
library(forcats)
library(labelled)
library(gtsummary)
library(dplyr)

# Load in data
here::i_am("code/02_make_barplot1.R")

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

barplot1 <- ggplot(breast_cancer) +
  aes(x = grade_revised, fill = status) +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = scales::percent) +
  scale_fill_manual(values = c(Alive = "#1EB2FF", Dead = "#FF5B53")) +
  labs(
    x = "Cancer Grade", 
    y = "Percent of Patients", 
    title = "Survival Status by Breast Cancer Grade", 
    subtitle = expression(italic("As a percentage of patients within each cancer grade")),
    fill = "Survival Status") +
  theme_bw()


ggsave(
  here::here("output/barplot1.png"),
  plot = barplot1,
  device = "png"
)
