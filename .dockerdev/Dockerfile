ARG RUBY_VERSION

FROM ruby:$RUBY_VERSION-alpine

ARG PG_MAJOR
ARG NODE_MAJOR
ARG BUNDLER_VERSION
ARG YARN_VERSION

RUN apk add --update --no-cache \
      binutils-gold \
      build-base \
      curl \
      file \
      g++ \
      gcc \
      gcompat \
      git \
      less \
      libc-dev \
      libc6-compat \
      libgcrypt-dev \
      libstdc++ \
      libffi-dev \
      libxml2-dev \
      libxslt-dev \
      libx11 \
      libxrender \
      libxext \
      libssl3 \
      yaml-dev \
      linux-headers \
      make \
      cmake \
      netcat-openbsd \
      nodejs \
      openssl \
      pkgconfig \
      # postgresql-dev \
      # postgresql-client \
      sqlite \
      python3-dev \
      python3 \
      tzdata \
      yarn \
      vim \
      shared-mime-info \
      sassc \
      imagemagick \
      openssh-client-default \
      # chromium \
      # chromium-chromedriver \
      ca-certificates \
      fontconfig \
      freetype \
      ttf-dejavu \
      ttf-droid \
      ttf-freefont \
      ttf-liberation \
      vips \
    && apk add --no-cache --virtual .build-deps \
        msttcorefonts-installer \
      \
      # Install microsoft fonts
      && update-ms-fonts \
      && fc-cache -f \
      \
      # Clean up when done
      && rm -rf /tmp/* \
      && apk del .build-deps


# Configure bundler
ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

RUN gem update --system && \
    gem install bundler:$BUNDLER_VERSION && \
    bundle config force_ruby_platform true

RUN mkdir -p /app

WORKDIR /app

ENTRYPOINT ["./.dockerdev/entrypoint.sh"]
