# VERSION 1.0
# DOCKER-VERSION  1.2.0
# AUTHOR:         Richard Lee <lifuzu@gmail.com>
# DESCRIPTION:    Syslog-ng Image Container

FROM dockerbase/ubuntu

MAINTAINER Richad Lee "lifuzu@gmail.com"

ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

# Run the build scripts
RUN	apt-get update

# Install openssh-server.
RUN	apt-get install -y --no-install-recommends openssh-server

# Config openssh-server.
RUN	mkdir /var/run/sshd

## Install default SSH key for root.
RUN	mkdir -p /root/.ssh && \
	chmod 700 /root/.ssh && \
	chown root:root /root/.ssh
ADD	build/insecure_key.pub /etc/insecure_key.pub
ADD	build/insecure_key /etc/insecure_key
RUN	chmod 644 /etc/insecure_key* && \
	chown root:root /etc/insecure_key*
ADD	build/bin/enable_insecure_key /usr/sbin/

# Clean up system
RUN	apt-get clean
RUN	rm -rf /tmp/* /var/tmp/*
RUN	rm -rf /var/lib/apt/lists/*

# Set environment variables.
ENV 	HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]
