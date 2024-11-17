# Rscript to make barplot 2

library(ggplot2)

# Load in data

ggplot(breast_cancer) +
  aes(x = status, fill = grade_revised) +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = scales::percent) +
  scale_fill_viridis_d(option = "plasma", 
                       direction = 1) +
  labs(
    x = "Survival Status", 
    y = "Percent of Patients", 
    title = "Breast Cancer Grade by Survival Status", 
    subtitle = expression(italic("As a percentage of patients within each survival status")), 
    fill = "Cancer Grade") +
  theme_bw()