# Rscript to create barplot 1

library(ggplot2)

# Load in data

ggplot(breast_cancer) +
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