
# -- Base image
FROM rocker/shiny

# -- system libraries
# RUN apt-get update && apt-get install -y \
# libcurl4-gnutls-dev

# -- Install R dependencies
# Shiny is already included in base image
# remotes needed at next step
RUN R -e "install.packages(c('remotes', 'RCurl', 'bslib', 'dplyr', 'ggplot2', 'ggforce', 'ggnewscale', 'geomtextpath', 'see', 'showtext'))"

# -- Install dependencies from GitHub
RUN R -e 'remotes::install_github("thekangaroofactory/ktools")'

# -- Make a directory in the container
RUN mkdir /home/shinyapp

# -- Copy the code
COPY R /home/shinyapp/R
COPY www /home/shinyapp/www
COPY *.R /home/shinyapp

# -- Expose the application port
EXPOSE 3838

# -- Run the Shiny app
CMD ["R", "-e", "shiny::runApp('/home/shinyapp', host = '0.0.0.0', port = 3838)"]


# -- build docker image:
# docker build -t rain-forecast-dashboard .

# -- run docker image:
# docker run -p 3838:3838 my-app-image

# -- access application
# http://localhost:3838/
