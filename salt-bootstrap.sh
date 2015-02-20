#!/bin/bash

Role=$1
Id=$2
Master=$3
Folder=$4
salt_ver=$5
repo=$6

[[ "$Role" == "master" ]] && Param="-M -N"
[[ "$Role" == "minion" ]] && Param="-i ${Id} -A ${Master}"

# check if salt is already installed
pgrep salt-${Role} &>/dev/null
if [[ "$?" -eq 0 ]] ; then
  echo "Salt package has been already installed."
  if [[ "${Role}" == "master" ]] ; then
    sudo salt '*' state.highstate
  fi
else
  sudo sh ${Folder}/install_salt.sh -F ${Param} -g ${repo} -p vim -p screen -p net-tools -p bash-completion -p vim -p git -p wget git v${salt_ver}
fi
