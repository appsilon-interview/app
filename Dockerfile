FROM rocker/shiny:4.0.4

# copy necessary files
## app folder
COPY /src ./app
## dependencies script
COPY /install_deps.R ./app/install_deps.R

RUN R -e "install.packages(c('devtools', 'packrat'))"
RUN R -e 'source("/app/install_deps.R", echo = TRUE)'

# expose port
EXPOSE 8080

# run app on container start
CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 8080)"]
