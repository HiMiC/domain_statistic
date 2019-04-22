FROM ubuntu:16.04
LABEL version="1.1"

MAINTAINER Alexey Manikin <alexey@beget.ru>

# Prepare environment
ENV DEBIAN_FRONTEND noninteractive

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8507EFA5

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  echo "deb http://repo.percona.com/apt xenial main" >> /etc/apt/sources.list.d/percona.list && \
  echo "deb-src http://repo.percona.com/apt xenial main" >> /etc/apt/sources.list.d/percona.list && \
  apt-get update && \
  apt-get install -y percona-server-server-5.6 percona-server-client-5.6 && \
  apt-get install -y locales git htop vim wget && \
  rm -rf /var/lib/apt/lists/*

# fix locales
ADD config/locales /var/lib/locales/supported.d/local
RUN locale-gen

ADD install_minit.sh /usr/local/sbin/install_minit.sh
RUN /bin/bash /usr/local/sbin/install_minit.sh

ADD config/my.cnf /etc/mysql/my.cnf

RUN addgroup --gid 950 mysql || true
RUN adduser --quiet --system --disabled-login --no-create-home --uid 950 --gid 950  mysql || true

RUN cd /root/ && \
    git clone -n https://github.com/akmua/domain_statistic.git --depth 1 && \
    cd domain_statistic && \
    git checkout HEAD structure.sql && \
    cp /root/domain_statistic/structure.sql /root/structure.sql && \
    rm -rf /root/domain_statistic;

RUN mkdir -p /etc/minit

ADD create_base.sh /root/create_base.sh
RUN chmod 755 /root/create_base.sh

ADD startup.sh /etc/minit/startup
RUN chmod 755 /etc/minit/startup
CMD ["/sbin/minit"]
# EOF







