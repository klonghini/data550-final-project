FROM rocker/tidyverse as base

RUN apt-get update && apt-get install -y pandoc
RUN apt-get update && apt-get install -y libcurl4-openssl-dev
RUN apt-get update && apt-get install -y zlib1g-dev
RUN apt-get update && apt-get install -y libxml2-dev
RUN apt-get update && apt-get install -y libfontconfig1-dev
RUN apt-get update && apt-get install -y libharfbuzz-dev 
RUN apt-get update && apt-get install -y libfribidi-dev
RUN apt-get update && apt-get install -y libfreetype6-dev
RUN apt-get update && apt-get install -y libpng-dev
RUN apt-get update && apt-get install -y libtiff5-dev
RUN apt-get update && apt-get install -y libjpeg-dev


# manually installing packages due to renv issues
RUN Rscript -e "install.packages('MASS')"
RUN Rscript -e "install.packages('cardx')"
RUN Rscript -e "install.packages('nloptr')"
RUN Rscript -e "install.packages('car')"
RUN Rscript -e "install.packages('broom.helpers')"

RUN mkdir /project
WORKDIR /project

# copy the essential renv files
RUN mkdir -p renv
COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json

RUN mkdir renv/.cache
ENV RENV_PATHS_CACHE renv/.cache

RUN Rscript -e "renv::restore(prompt=FALSE)"

###### END OF BUILD 1 ######


FROM rocker/tidyverse

RUN apt-get update && apt-get install -y pandoc
RUN apt-get update && apt-get install -y libcurl4-openssl-dev
RUN apt-get update && apt-get install -y zlib1g-dev
RUN apt-get update && apt-get install -y libxml2-dev
RUN apt-get update && apt-get install -y libfontconfig1-dev
RUN apt-get update && apt-get install -y libharfbuzz-dev 
RUN apt-get update && apt-get install -y libfribidi-dev
RUN apt-get update && apt-get install -y libfreetype6-dev
RUN apt-get update && apt-get install -y libpng-dev
RUN apt-get update && apt-get install -y libtiff5-dev
RUN apt-get update && apt-get install -y libjpeg-dev
RUN apt-get update && apt-get install -y cmake

WORKDIR /project
COPY --from=base /project .

# manually installing packages due to renv issues
RUN Rscript -e "install.packages('MASS')"
RUN Rscript -e "install.packages('cardx')"
RUN Rscript -e "install.packages('nloptr')"
RUN Rscript -e "install.packages('car')"
RUN Rscript -e "install.packages('broom.helpers')"
RUN Rscript -e "install.packages('parameters')"
RUN Rscript -e "install.packages('labelled')"

RUN mkdir /project/code
RUN mkdir /project/data
RUN mkdir /project/output

# copy important project files
COPY code /project/code
COPY data/Breast_Cancer.csv /project/data
COPY Makefile .
COPY final_report.Rmd .

RUN mkdir report

CMD make && mv final_report.html report

