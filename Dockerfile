# VERSION 1.1
# DOCKER-VERSION  1.2.0
# AUTHOR:         Richard Lee <lifuzu@gmail.com>
# DESCRIPTION:    Openssh-server Image Container

FROM dockerbase/runit

ADD	build/insecure_key.pub /etc/insecure_key.pub
ADD	build/insecure_key /etc/insecure_key
ADD	build/bin/enable_insecure_key /usr/sbin/

# Run dockerbase script
ADD     openssh-server.sh /dockerbase/
RUN     /dockerbase/openssh-server.sh

# Add sshd into runit
ADD     build/runit/sshd /etc/service/sshd/run
