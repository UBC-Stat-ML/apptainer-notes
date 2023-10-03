FROM julia:1.9.3-bookworm

RUN apt-get update && apt-get install -y \
  ca-certificates \
  wget curl unzip zip \
  procps \
  git \
  build-essential g++ 

# java 11 via sdkman
RUN curl -s "https://get.sdkman.io" | bash
RUN bash -c "source /root/.sdkman/bin/sdkman-init.sh && sdk install java 11.0.20-tem"
RUN mv /root/.sdkman /usr/local/sdkman
ENV PATH="$PATH:/usr/local/sdkman/candidates/java/current/bin/"

# cmdstan
# based on https://github.com/tpapp/cmdstan-docker/
ENV CMDSTAN_VERSION 2.33.1
RUN wget --progress=dot:mega "https://github.com/stan-dev/cmdstan/releases/download/v$CMDSTAN_VERSION/cmdstan-$CMDSTAN_VERSION.tar.gz" && \
        tar -zxpf "cmdstan-$CMDSTAN_VERSION.tar.gz" && \
        cd "cmdstan-$CMDSTAN_VERSION" && \
        make build
ENV CMDSTAN=/cmdstan-$CMDSTAN_VERSION

# clean up to reduce image size
RUN rm cmdstan-$CMDSTAN_VERSION.tar.gz
RUN rm -rf /var/lib/apt/lists/*
