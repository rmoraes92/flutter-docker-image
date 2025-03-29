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
COPY assets/flutter sdk
RUN git config --global --add safe.directory /home/ubuntu/sdk/flutter
ENV PATH="/home/ubuntu/sdk/flutter/bin:/home/ubuntu/sdk/flutter/bin/cache/dart-sdk/bin:${PATH}"
RUN flutter --version
CMD ["flutter"]
