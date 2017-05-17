FROM node:7.10.0

# Install packages

## Add backports repo for certbot
RUN echo "deb http://ftp.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jbackports.list

RUN apt-get update

## Cert tools
RUN apt-get install certbot -t jessie-backports -y
RUN apt-get install openssl -y

## pip and Ansible
RUN apt-get install python-dev python-pip -y
RUN pip install --upgrade cffi
RUN pip install ansible

## Nodemon for dev
RUN npm install -g nodemon

# Add app
ADD start.sh /root/start.sh
WORKDIR /opt/app
ENTRYPOINT ["/root/start.sh"]
