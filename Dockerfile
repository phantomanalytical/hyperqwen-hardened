FROM ghcr.io/syv-ai/hyperqwen@sha256:d45c405319543d5691c43cfafadd7999d4e2d47f059e0c9227f22ef4ad39a607

USER root

RUN apt-get update \
    && apt-get upgrade -y \
    && rm -rf /var/lib/apt/lists/*
