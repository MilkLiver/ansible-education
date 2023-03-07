#!/bin/bash

ANSIBLE_EDU_CONNECT_SHELL_DIR=/opt/ansible-edu/connectController

echo "export ANSIBLE_EDU_SHELL_DIR=$ANSIBLE_EDU_CONNECT_SHELL_DIR" >>/etc/profile
echo 'export PATH=$PATH:$ANSIBLE_EDU_SHELL_DIR' >>/etc/profile
source /etc/profile
