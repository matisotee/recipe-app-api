FROM python:3.7-alpine
MAINTAINER Matias Sotelo

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt

RUN apk update && \
    apk add postgresql-dev && \
    apk add --no-cache --virtual .build-deps \
    gcc \
    python3-dev \
    musl-dev \
    && pip install --no-cache-dir psycopg2 \
    && pip install --no-cache-dir psycopg2-binary \
    && pip install  --no-cache-dir -r requirements.txt \
    && apk del --no-cache .build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user
