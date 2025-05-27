# ---- Stage 1: Build Stage ----
FROM python:3-slim-bookworm AS builder

WORKDIR /app


COPY requirements.txt ./

# Install Python deps to a temporary location
RUN pip install --upgrade pip && \
    pip install --no-cache-dir --prefix=/install -r requirements.txt

# ---- Stage 2: Runtime Image ----
FROM python:3-slim-bookworm

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/nikos/python3-alpine-flask-docker"

ARG BUILD_DATE
ARG VCS_REF

WORKDIR /app

# Copy only installed packages and your app code
COPY --from=builder /install /usr/local
COPY . .


RUN useradd --create-home --shell /bin/bash appuser
USER appuser

EXPOSE 5050
CMD ["python", "app.py"]
