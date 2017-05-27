#!/bin/bash

# Source of tarball: https://github.com/ansible/ansible/releases

# Several settings
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >>/dev/null && pwd )/"
TMP_DIR="${DIR}tmp/"
SCRIPT_VERSION=1
ANSIBLE_VERSION=2.3.0.0-1
VERSION="${ANSIBLE_VERSION}-###${SCRIPT_VERSION}###"
INSTALL_PATH="/opt/ansible/"
CONFIG_PATH="/etc/ansible/"
VERSION_FILE="${INSTALL_PATH}VERSION"
ANSIBLE_FOLDER="ansible-${ANSIBLE_VERSION}"
SOURCE_CMD="source ${INSTALL_PATH}hacking/env-setup &>/dev/null"
PKG_FILE="${ANSIBLE_FOLDER}.tar.gz"
DOWNLOAD_URL="https://github.com/ansible/ansible/archive/v${ANSIBLE_VERSION}.tar.gz"

if [ -d $INSTALL_PATH ]; then
  if [ -f $VERSION_FILE ]; then
    if grep -Fxq $VERSION "$VERSION_FILE"; then
      echo "Already current version"
      exit
    else
      echo "Upgrading"
    fi
  else
    echo "Upgrading"
  fi
else
  echo "Installing"
fi

if [ ! -f "${DIR}${PKG_FILE}" ]; then
  echo "Downloading"
  curl -L -o "${DIR}${PKG_FILE}" ${DOWNLOAD_URL}
fi

if [ ! -f "${DIR}${PKG_FILE}" ]; then
  echo "Download of ${DOWNLOAD_URL} failed!"
  exit
fi

# Remove old versions
rm -f /usr/local/bin/ansible*
rm -rf $INSTALL_PATH

# Install new
mkdir -p $TMP_DIR
mkdir -p $CONFIG_PATH
tar -xzf "${DIR}${PKG_FILE}" -C $TMP_DIR
mv "${TMP_DIR}${ANSIBLE_FOLDER}" "/opt"
mv "/opt/${ANSIBLE_FOLDER}" $INSTALL_PATH

cp -pr ${DIR}config/* $CONFIG_PATH

# Install requirements
apt-get update
apt-get install sshpass -y
apt-get install python -y
apt-get install python-dev -y
apt-get install build-essential -y
apt-get install python-setuptools -y
apt-get install libssl-dev libpq-dev libxml2-dev libxslt1-dev libldap2-dev libsasl2-dev libffi-dev -y
easy_install pip
pip install -r "${INSTALL_PATH}requirements.txt"

# Add environment setup
grep -q -F "$SOURCE_CMD" /etc/profile || echo "$SOURCE_CMD" >> /etc/profile

# New symlinks
ln -s "${INSTALL_PATH}bin/ansible" /usr/local/bin/ansible
ln -s "${INSTALL_PATH}bin/ansible-connection" /usr/local/bin/ansible-connection
ln -s "${INSTALL_PATH}bin/ansible-console" /usr/local/bin/ansible-console
ln -s "${INSTALL_PATH}bin/ansible-doc" /usr/local/bin/ansible-doc
ln -s "${INSTALL_PATH}bin/ansible-galaxy" /usr/local/bin/ansible-galaxy
ln -s "${INSTALL_PATH}bin/ansible-playbook" /usr/local/bin/ansible-playbook
ln -s "${INSTALL_PATH}bin/ansible-pull" /usr/local/bin/ansible-pull

# Clean up
rmdir $TMP_DIR

# Add version file
echo "${VERSION}" >> "${VERSION_FILE}"

eval $SOURCE_CMD
