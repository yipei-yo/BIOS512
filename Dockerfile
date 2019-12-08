FROM rocker/binder:3.6.0

ARG NB_USER
ARG NB_UID

RUN pip3 install jupyterlab==1.0.9

COPY install.R ./
RUN  R -f install.R

FROM jupyter/r-notebook:ad3574d3c5c7

USER ${NB_USER}

RUN conda update -n base conda
RUN conda install -y r-tidyr==1.0.0 r-ggraph==2.0.0 r-ggrepel==0.8.1

RUN R -e "devtools::install_github('thomasp85/patchwork')"

# USER root
# RUN apt-get update \
#   && apt-get install --yes libv8-dev
# USER $NB_USER

RUN conda install libv8==7.5.288.30
RUN R -e "devtools::install_github('hoesler/rwantshue')"
