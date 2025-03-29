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
COPY --chown=ubuntu assets/flutter flutter
RUN git config --global --add safe.directory /home/ubuntu/flutter
ENV PATH=/home/ubuntu/flutter/bin:/home/ubuntu/flutter/.cache/bin:${PATH}
RUN flutter --disable-analytics
CMD ["flutter"]
