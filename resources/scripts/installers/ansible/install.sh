#!/bin/bash

# Several settings
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >>/dev/null && pwd )"
TMP_DIR="${DIR}/tmp"
VERSION=2.3.0.0-1
ANSIBLE_FOLDER="ansible-${VERSION}"
SOURCE_CMD="source /opt/ansible/hacking/env-setup &>/dev/null"

# Remove old versions
rm -f /usr/local/bin/ansible*
rm -rf "/opt/ansible"

# Install new
mkdir -p $TMP_DIR
mkdir -p /etc/ansible
tar -xzf "${DIR}/${ANSIBLE_FOLDER}.tar.gz" -C $TMP_DIR
mv "${TMP_DIR}/${ANSIBLE_FOLDER}" "/opt"
mv "/opt/${ANSIBLE_FOLDER}" "/opt/ansible"

echo "127.0.0.1" > /etc/ansible/hosts

# Install requirements
apt-get update
apt-get install sshpass -y
apt-get install python -y
apt-get install python-dev -y
apt-get install build-essential -y
apt-get install python-setuptools -y
apt-get install libssl-dev libpq-dev libxml2-dev libxslt1-dev libldap2-dev libsasl2-dev libffi-dev -y
easy_install pip
pip install -r /opt/ansible/requirements.txt

# Add environment setup
grep -q -F "$SOURCE_CMD" /etc/profile || echo "$SOURCE_CMD" >> /etc/profile

# New symlinks
ln -s /opt/ansible/bin/ansible /usr/local/bin/ansible
ln -s /opt/ansible/bin/ansible-connection /usr/local/bin/ansible-connection
ln -s /opt/ansible/bin/ansible-console /usr/local/bin/ansible-console
ln -s /opt/ansible/bin/ansible-doc /usr/local/bin/ansible-doc
ln -s /opt/ansible/bin/ansible-galaxy /usr/local/bin/ansible-galaxy
ln -s /opt/ansible/bin/ansible-playbook /usr/local/bin/ansible-playbook
ln -s /opt/ansible/bin/ansible-pull /usr/local/bin/ansible-pull

# Clean up
rmdir $TMP_DIR
