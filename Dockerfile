FROM ubuntu:17.04

RUN adduser buildozer --disabled-password --disabled-login
RUN apt-get update && apt-get install -y git python-pip zlib1g-dev openjdk-8-jdk-headless
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y build-essential ccache git libncurses5:i386 libstdc++6:i386 libgtk2.0-0:i386 libpangox-1.0-0:i386 libpangoxft-1.0-0:i386 libidn11:i386 python2.7 python2.7-dev openjdk-8-jdk unzip zlib1g-dev zlib1g:i386

ADD dummy /buildozer/dummy
RUN chown -R buildozer:buildozer /buildozer/
RUN pip install cython==0.25 buildozer

USER buildozer

RUN \
  cd /buildozer/dummy && \
  buildozer android debug

VOLUME /buildozer/

WORKDIR /buildozer/

CMD buildozer android debug
