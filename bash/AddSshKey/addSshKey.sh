#!/bin/bash

# ------------------------------------------------------------------------------------
# USE AT YOUR OWN RISK. Tested on Linux Mint 17.1
# CHECK COMMENTS BEFORE RUNNING
#
# This script send and add your public SSH Key to Remote Server
# eg. "./addSshKey.sh marcinos 123.123.123.123 222" will send and add your public SSH Key.
#
# variables:
# ----------
# marcinos - username
# 123.123.123.123 - hostname
# 222 - port
#
# If remote server (or your machine) doesn't have ~/.ssh folder You can create it by command:
# ssh-keygen -t rsa
# ------------------------------------------------------------------------------------

user=${1}
host=${2}
port=${3}

aurhorized_keys_file=.ssh/authorized_keys

#check variables
#if user is empty - exit
if [ -z ${user} ]; then
    echo "You must add username"
    exit
fi
#if host is empty - exit
if [ -z ${host} ]; then
    echo "You must add hostname"
    exit
fi
#if port is empty - set 22
if [ -z ${port} ]; then
    port=22
fi

# sprawdzamy czy istnieje authorized_keys
if ssh -p ${port} ${user}@${host} stat ${aurhorized_keys_file} \> /dev/null 2\>\&1
    then
        echo File ${aurhorized_keys_file} exists
    else
        echo File ${aurhorized_keys_file} does not exist - create it
        ssh -p ${port} ${user}@${host} 'touch .ssh/authorized_keys'
fi

cat ~/.ssh/id_rsa.pub | ssh -p ${port} ${user}@${host} 'cat >> .ssh/authorized_keys'
