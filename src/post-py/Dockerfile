FROM python:3.6.0-alpine

ENV POST_DATABASE_HOST post_db
ENV POST_DATABASE posts

WORKDIR /app
COPY requirements.txt  ./

RUN apk add --no-cache --update --virtual .build-deps build-base && \
    pip install --no-cache-dir -r requirements.txt && \
    apk del .build-deps

ADD . /app

ENTRYPOINT ["python3"]
CMD ["post_app.py"]
