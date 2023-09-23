FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
  wget curl unzip zip \
  procps \
  git \
  r-base

# java 11 via sdkman
RUN curl -s "https://get.sdkman.io" | bash
RUN bash -c "source /root/.sdkman/bin/sdkman-init.sh && sdk install java 11.0.20-tem"
RUN mv /root/.sdkman /usr/local/sdkman
ENV PATH="$PATH:/usr/local/sdkman/candidates/java/current/bin/"

WORKDIR "/usr/local"
RUN git clone https://github.com/UBC-Stat-ML/blangSDK.git
WORKDIR "/usr/local/blangSDK"
RUN bash setup-cli.sh
ENV PATH="$PATH:/usr/local/blangSDK/build/install/blang/bin"

RUN R -e "install.packages(c('dplyr', 'ggplot2', 'tidyr'), \
                           dependencies=TRUE, \
                           repos='http://cran.rstudio.com/')"

ENTRYPOINT ["blang"]

# clean up to reduce image size
RUN rm -rf /var/lib/apt/lists/*
