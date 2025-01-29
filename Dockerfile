FROM mcr.microsoft.com/vscode/devcontainers/python:3.13-bookworm

# This env var is used to force the 
# rebuild of the GitHub Codespaces environment when needed
ENV TRIGGER_REBUILD 1

# Gets rid of extra output in the cli
ENV GIT_DISCOVERY_ACROSS_FILESYSTEM=true

USER root

RUN git config --system user.email "trainee@dataminded.be" && \
  git config --global user.name "Git trainee" && \
  git config --global init.defaultBranch master

USER vscode
ENV HOME /home/vscode
# Copy exercices content into the image
COPY --chown=vscode content/ $HOME/git-exercices

# Set up the exercices
RUN /bin/bash $HOME/git-exercices/resources/bootstrap.sh && \
  sudo rm -rf $HOME/git-exercices/resources
