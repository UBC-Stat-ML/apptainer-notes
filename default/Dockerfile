FROM julia:1.9.3-bookworm

RUN apt-get update && apt-get install -y \
  wget curl unzip zip # for sdkman \
  procps # nextflow instrumentation \
  git \
  build-essential make g++ # for Stan 

# java 11 via sdkman
RUN curl -s "https://get.sdkman.io" | bash
RUN bash -c "source /root/.sdkman/bin/sdkman-init.sh && sdk install java 11.0.20-tem"
RUN mv /root/.sdkman /usr/local/sdkman
ENV PATH="$PATH:/usr/local/sdkman/candidates/java/current/bin/"

# clean up to reduce image size
RUN rm -rf /var/lib/apt/lists/*
