FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        latexmk \
        texlive-luatex \
        texlive-lang-japanese \
        texlive-pictures \
        fonts-ipaexfont \
        fonts-urw-base35 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work
