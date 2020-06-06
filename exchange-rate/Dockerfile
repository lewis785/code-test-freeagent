FROM ruby:2.7.1-alpine

RUN apk update \
    && apk add --no-cache bash \
    && rm -rf /tmp/* \
    && apk add supervisor \
    && mkdir -p /var/log/supervisor \
    && rm -rf /var/cache/apk/*

RUN mkdir /var/app

WORKDIR /var/app

COPY Gemfile ./
COPY Gemfile.lock ./

RUN bundle install

COPY . .
# COPY data ./data
# COPY lib ./lib
# COPY test ./test