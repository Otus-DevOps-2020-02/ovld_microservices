FROM alpine:3.4


ENV POST_SERVICE_HOST post
ENV POST_SERVICE_PORT 5000
ENV COMMENT_SERVICE_HOST comment
ENV COMMENT_SERVICE_PORT 9292

WORKDIR /app

COPY Gem* ./

RUN apk --no-cache add ruby ruby-dev ruby-bundler ruby-json && \
    apk add --no-cache --update --virtual .build-deps build-base && \
    bundle install && \
    apk del .build-deps

ADD . .

CMD ["puma"]
