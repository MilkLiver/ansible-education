#!/bin/bash

STUDENT_NUMBERS=3
ANSIBLE_EDU_CONNECT_SHELL_DIR=./connectController

ANSIBLE_EDU_ENV_PREFIX=student

for ((studentN = 1; studentN <= $STUDENT_NUMBERS; studentN += 1)); do

    ANSIBLE_EDU_ENV=$ANSIBLE_EDU_ENV_PREFIX$studentN

    echo "ANSIBLE_EDU_ENV = $ANSIBLE_EDU_ENV"

    echo "delete $ANSIBLE_EDU_ENV env ..."

    podman rm -f $ANSIBLE_EDU_ENV-controller
    podman rm -f $ANSIBLE_EDU_ENV-node01
    podman rm -f $ANSIBLE_EDU_ENV-node02
    podman network rm $ANSIBLE_EDU_ENV

    rm -f $ANSIBLE_EDU_CONNECT_SHELL_DIR/ansible-edu-$ANSIBLE_EDU_ENV

    echo "delete $ANSIBLE_EDU_ENV env success"

done
