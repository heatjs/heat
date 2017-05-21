#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >>/dev/null && pwd )"

if [ $DIR = "/tmp" ]; then
  echo "THIS IS VAGRANT!"
  # This is running from vagrant provision, run inside project folder
  /vagrant/resources/scripts/installers/console.sh
else
  apt-get update

  apt-get install python -y

  # Ansible
  ${DIR}/ansible/install.sh
fi



# Redis
# echo 1 > /proc/sys/vm/overcommit_memory

#
