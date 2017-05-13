FROM ubuntu:16.04

RUN apt-get update

RUN apt-get install openssh-server -y
RUN apt-get install openssh-client -y
RUN apt-get install python -y

RUN mkdir /var/run/sshd

ADD authorized_keys /root/.ssh/
# ADD sshd_config /etc/ssh/sshd_config

RUN ssh-keygen -q -t rsa -N '' -f /root/.ssh/id_rsa

RUN chmod 700 /root/.ssh
RUN chmod 600 /root/.ssh/authorized_keys

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
