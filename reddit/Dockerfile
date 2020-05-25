FROM alpine:3.4

WORKDIR /app

COPY Gem* ./

RUN apk --no-cache add ruby ruby-dev ruby-bundler ruby-json && \
  apk add --no-cache --update --virtual .build-deps build-base && \
  bundle install && \
  apk del .build-deps

ADD . .

CMD ["puma"]
