# Make rules for report

# build the report
final_report.html: final_report.Rmd code/05_render_report.R data/breast_cancer.rds output/table1.rds output/barplot1.png output/barplot2.png output/regression_model.rds
	Rscript code/05_render_report.R

# create the output of code/00_clean_data.R
data/breast_cancer.rds: code/00_clean_data.R data/Breast_cancer.csv
	Rscript code/00_clean_data.R

# create the output of code/01_make_table1.R
output/table1.rds: code/01_make_table1.R data/breast_cancer.rds
	Rscript code/01_make_table1.R
	
# create the output of code/02_make_barplot1.R
output/barplot1.png: code/02_make_barplot1.R data/breast_cancer.rds
	Rscript code/02_make_barplot1.R
 
# create the output of code/03_make_barplot2.R
output/barplot2.png: code/03_make_barplot2.R data/breast_cancer.rds
	Rscript code/03_make_barplot2.R
	
# create the output of code/04_make_regression_primary_model.R
output/regression_model.rds: code/04_make_regression_primary_model.R data/breast_cancer.rds
	Rscript code/04_make_regression_primary_model.R
	
	
.PHONY: clean
clean:
	rm -f data/*.rds output/*.png && \
	rm -f final_report.html
