FROM python:3.9-alpine3.13
LABEL maintainer="gyeongdo"

ENV PYTHONUNBUFFERED=1

# 필요한 파일 복사
COPY ./app /app
COPY poetry.lock /app/poetry.lock
COPY pyproject.toml /app/pyproject.toml

WORKDIR /app
EXPOSE 8000

# 개발 모드 여부를 위한 ARG
ARG DEV=false

# 필요한 패키지 설치 및 사용자 추가
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install --no-cache-dir poetry && \
    if [ "$DEV" = "true" ]; then /py/bin/poetry install --no-root; fi && \
    /py/bin/poetry install --no-root --no-dev && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

# 가상 환경 경로를 PATH에 추가
ENV PATH="/py/bin:$PATH"

# 비루트 사용자로 실행
USER django-user