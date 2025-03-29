FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    libglu1-mesa \
    libxrender1 \
    libxtst6

# Install Flutter SDK
USER ubuntu
WORKDIR /home/ubuntu

ADD flutter_linux_3.29.2-stable.tar.xz sdk
RUN git config --global --add safe.directory /home/ubuntu/sdk/flutter

# Set Flutter environment variables
ENV PATH="/home/ubuntu/sdk/flutter/bin:/home/ubuntu/sdk/flutter/bin/cache/dart-sdk/bin:${PATH}"
CMD = ["flutter"]
