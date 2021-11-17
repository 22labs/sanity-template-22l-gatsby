ARG NODE_VERSION=14.15.3-buster

FROM node:"${NODE_VERSION}"

# Metadata
LABEL maintainer="Twenty Two Labs"

# User and Group for app isolation
ARG APP_UID=1069
ARG APP_USER=app
ARG APP_GID=1420
ARG APP_GROUP=app
ARG APP_DIR=/app

ENV SHELL /bin/bash

ARG PACKAGES="\
  apt-utils \
  build-essential \
  execline \
  less \
  man \
  nasm \
  "

# Install packages
RUN apt clean && apt update -qq && \
  apt dist-upgrade -q -y && \
  apt install --no-install-recommends -y ${PACKAGES} && \
  rm -rf /var/lib/apt/lists/*

# Configure Node and PATH
ENV NODE_MODULES_DIR "${APP_DIR}/node_modules"
ENV NODE_BIN_DIR "${NODE_MODULES_DIR}/.bin"
ENV PATH "${NODE_BIN_DIR}:${PATH}"

# Add custom app User and Group
RUN addgroup --gid "${APP_GID}" "${APP_GROUP}" && \
  adduser --disabled-password --quiet --gid "${APP_GID}" --uid "${APP_UID}" "${APP_USER}"

# Create directories for the app code
RUN mkdir -p "${APP_DIR}" \
  "${APP_DIR}/tmp" \
  "${NODE_MODULES_DIR}" \
  "${NODE_BIN_DIR}"
RUN chown -R "${APP_USER}":"${APP_GROUP}" "${APP_DIR}" \
  "${NODE_MODULES_DIR}" \
  "${NODE_BIN_DIR}"

USER "${APP_USER}"

WORKDIR "${APP_DIR}"

# Expose the Gatsby server port
EXPOSE 8000

# Commands will be supplied via `docker-compose`
CMD []
