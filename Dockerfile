FROM ubuntu:18.04

RUN apt-get update \
 && apt-get install -y \
    git zlib1g-dev openjdk-8-jdk-headless autoconf curl libtool \
    libpq-dev libssl-dev ccache unzip zip python3 \
    python3-virtualenv python3-pip pkg-config cmake libffi-dev \
 && pip3 install cython buildozer

RUN mkdir -p /buildozer/ \
 && touch main.py \
 && yes | buildozer init . \
 && sed -i 's/warn_on_root.*/warn_on_root = 0/' buildozer.spec \
 && yes | buildozer android debug

VOLUME /buildozer/
VOLUME /p4a/
volume /opt/

WORKDIR /buildozer/

CMD buildozer android debug
