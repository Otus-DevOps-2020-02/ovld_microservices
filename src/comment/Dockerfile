FROM alpine:3.4

ENV COMMENT_DATABASE_HOST comment_db
ENV COMMENT_DATABASE comments

WORKDIR /app

COPY Gem* ./

RUN apk --no-cache add ruby ruby-dev ruby-bundler ruby-json && \
    apk add --no-cache --update --virtual .build-deps build-base && \
    bundle install && \
    apk del .build-deps

ADD . .

CMD ["puma"]
