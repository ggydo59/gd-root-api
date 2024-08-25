FROM python:3.9-alpine3.13
LABEL maintainer="gyeongdo"

ENV PYTHONUNBUFFERED 1
COPY ./app /app
COPY poetry.lock /app/poetry.lock
COPY pyproject.toml /app/pyproject.toml

WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    source /py/bin/activate && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install --no-cache-dir poetry && \
    if [ $DEV = "true"]; \
        then poetry install --no-root ; \
    fi && \
    poetry lock --no-update && \
    poetry install --no-root --no-dev && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"
USER django-user