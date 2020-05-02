FROM python:3.8-alpine

MAINTAINER Daniel San "daniel.samrocha@gmail.com"

LABEL maintainer="Daniel San" \
    description="Container to connect to AWS services"

RUN apk update

RUN apk add --no-cache --virtual .build-deps

RUN apk add --no-cache \
    musl-dev \
    libffi-dev \
    openssl-dev \
    python3-dev \
    libsodium-dev \
    gcc \
    git \
    openssh-client \
    zsh

RUN addgroup -S awscli && adduser -S awscli -G awscli

WORKDIR /home/awscli

RUN mkdir venvs && \
    python -m venv venvs/aws && \
    python -m venv venvs/eb

RUN source venvs/aws/bin/activate && \
    pip install --upgrade pip && \
    pip install --no-cache-dir awscli && \
    deactivate

RUN source venvs/eb/bin/activate && \
    pip install --upgrade pip setuptools wheel && \
    SODIUM_INSTALL=system pip install pynacl && \
    pip install --no-cache-dir 'awsebcli>=3.18.0,<3.19' && \
    pip uninstall -y wheel && \
    deactivate

RUN chown -R awscli:awscli venvs

USER awscli

ADD --chown=awscli:awscli https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh /home/awscli

RUN sh install.sh && rm install.sh

USER root

RUN apk del \
    musl-dev \
    libffi-dev \
    openssl-dev \
    python3-dev \
    libsodium-dev \
    gcc \
    git

USER awscli

