FROM alpine:3.10.1
MAINTAINER guillermo@guerreroibarra.com

ENV APP_HOME=/app

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-p", "3000"]

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

RUN apk update && apk add build-base ruby ruby-dev ruby-bundler ruby-json \
                          ruby-bigdecimal sqlite-dev sqlite
RUN rm -rf /var/cache/apk/*

ADD Gemfile Gemfile.lock $APP_HOME/
RUN bundle install

COPY . $APP_HOME
