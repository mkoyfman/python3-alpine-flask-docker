FROM python:3-slim-bookworm
MAINTAINER Niko Schmuck <niko@nava.de> 

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/nikos/python3-alpine-flask-docker"

WORKDIR /app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

# Create a non-root user and switch to it
RUN useradd --create-home appuser
USER appuser

EXPOSE 5050
CMD ["python", "app.py"]
