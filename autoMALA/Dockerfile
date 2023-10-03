FROM julia:1.9.3-bookworm

RUN apt-get update && apt-get install -y \
        wget ca-certificates make g++

# cmdstan
# based on https://github.com/tpapp/cmdstan-docker/
ENV CMDSTAN_VERSION 2.33.1
RUN wget --progress=dot:mega "https://github.com/stan-dev/cmdstan/releases/download/v$CMDSTAN_VERSION/cmdstan-$CMDSTAN_VERSION.tar.gz" && \
        tar -zxpf "cmdstan-$CMDSTAN_VERSION.tar.gz" && \
        cd "cmdstan-$CMDSTAN_VERSION" && \
        make build
ENV CMDSTAN=/cmdstan-$CMDSTAN_VERSION

# clean up to reduce image size
RUN rm -rf /var/lib/apt/lists/*

