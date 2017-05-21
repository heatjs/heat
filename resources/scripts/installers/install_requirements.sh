#!/bin/bash

sudo apt-get update

sudo apt-get install openssh-server -y
sudo apt-get install openssh-client -y
sudo apt-get install python -y

RUN mkdir /var/run/sshd

# ADD authorized_keys /root/.ssh/
# RUN ssh-keygen -q -t rsa -N '' -f /root/.ssh/id_rsa
