FROM julia:1.9.3-bookworm

RUN apt-get update && apt-get install -y \
  procps \
  git \
  build-essential \
  g++ \
  && rm -rf /var/lib/apt/lists/*