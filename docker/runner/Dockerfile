FROM ubuntu:16.04
LABEL version="1.2"

MAINTAINER Alexey Manikin <alexey@beget.ru>

# Prepare environment
ENV DEBIAN_FRONTEND noninteractive

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  apt-get install --no-install-recommends -qq -y git build-essential cron libpython2.7 python-minimal\
                    python-all-dev python-subnettree \
                    python-mysqldb python-psutil && \
  apt-get update && \
  apt-get install -y zlib1g-dev libbz2-dev python-dev libmysqlclient-dev mc net-tools && \
  wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py && rm get-pip.py && \
  pip install dnspython && \
  pip install psutil && \
  pip install MySQL-python && \
  apt-get clean && \
  rm -rf /etc/localtime && \
  ln -s /usr/share/zoneinfo/Europe/Moscow /etc/localtime && \
  rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*;

ADD install_minit.sh /usr/local/sbin/install_minit.sh
RUN /bin/bash /usr/local/sbin/install_minit.sh

ADD install_code.sh /usr/local/sbin/install_code.sh
RUN /bin/bash /usr/local/sbin/install_code.sh

# need for developing
RUN apt-get update && \
    apt-get install -y openssh-server && \
    mkdir /root/.ssh;

ADD config/sshd_config /etc/ssh/sshd_config
ADD config/authorized_keys /root/.ssh/authorized_keys

ADD init.sh /etc/minit/startup
RUN chmod 755 /etc/minit/startup
CMD ["/sbin/minit"]
# EOF
