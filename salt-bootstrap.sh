#!/bin/bash

Role=$1
Folder=$4

if [[ "$Role" == "master" ]] ; then
  Param="-M -N"
  cd /srv
elif [[ "$Role" == "minion" ]] ; then
  Id=$2
  Master=$3
  Param="-i ${Id} -A ${Master}"
#  sed -e "s/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\(\ \+master\)/${i}\1/" /etc/hosts
else
  echo "Parameter should be master or minion."
  exit
fi

Stat=$(rpm -qa | grep -E -o "salt-master|salt-minion" | awk -F"-" '{print $2}')

if [[ "$Stat" == "master" ]] ; then
  sudo salt '*' state.highstate
elif [[ "$Stat" == "minion" ]] ; then
  echo "Salt package has been already installed."
#  exit
else
  sudo sh ${Folder}/install_salt.sh ${Param} -p vim -p screen -p net-tools -p bash-completion -p vim -p git -p wget
fi

