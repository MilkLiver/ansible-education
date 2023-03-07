#!/bin/bash

STUDENT_NUMBERS=3
VM_IP=xxx.xxx.xxx.xxx
EDUCATION_IMAGE_VERSION=1.4.0

WORKSPACE_ROOT_DIR=/opt/ansible-edu
ANSIBLE_EDU_CONNECT_SHELL_DIR=/opt/ansible-edu/connectController

ANSIBLE_EDU_ENV_PREFIX=student
ANSIBLE_EDU_PORT_START=20000

totalPorts=$(($STUDENT_NUMBERS * 2))

mkdir -p $WORKSPACE_ROOT_DIR
mkdir -p $ANSIBLE_EDU_CONNECT_SHELL_DIR
for ((studentN = 1, portN = 1; studentN <= $STUDENT_NUMBERS; portN += 2, studentN += 1)); do

    ANSIBLE_EDU_ENV=$ANSIBLE_EDU_ENV_PREFIX$studentN
    ANSIBLE_EDU_NODE01_PORT=$(($ANSIBLE_EDU_PORT_START + $portN))
    ANSIBLE_EDU_NODE02_PORT=$(($ANSIBLE_EDU_PORT_START + $portN + 1))

    echo "ANSIBLE_EDU_ENV = $ANSIBLE_EDU_ENV"
    echo "ANSIBLE_EDU_NODE01_PORT = $ANSIBLE_EDU_NODE01_PORT"
    echo "ANSIBLE_EDU_NODE02_PORT = $ANSIBLE_EDU_NODE02_PORT"

    echo "create $ANSIBLE_EDU_ENV env ..."

    mkdir -p $WORKSPACE_ROOT_DIR/$ANSIBLE_EDU_ENV

    podman network create $ANSIBLE_EDU_ENV

    podman run -e VM_IP=$VM_IP -e ANSIBLE_EDU_ENV=$ANSIBLE_EDU_ENV -e ANSIBLE_EDU_NODE01_PORT=$ANSIBLE_EDU_NODE01_PORT -e ANSIBLE_EDU_NODE02_PORT=$ANSIBLE_EDU_NODE02_PORT -v $WORKSPACE_ROOT_DIR/$ANSIBLE_EDU_ENV:/workspace --network $ANSIBLE_EDU_ENV --network $ANSIBLE_EDU_ENV -idt --name $ANSIBLE_EDU_ENV-controller docker.io/milkliver/ansible-education-controller-container:$EDUCATION_IMAGE_VERSION

    podman run --cap-add AUDIT_WRITE -e VM_IP=$VM_IP -e ANSIBLE_EDU_ENV=$ANSIBLE_EDU_ENV -e SSH_PORT=$ANSIBLE_EDU_NODE01_PORT --network $ANSIBLE_EDU_ENV -p $ANSIBLE_EDU_NODE01_PORT:22 -idt --name $ANSIBLE_EDU_ENV-node01 docker.io/milkliver/ansible-education-node01-container:$EDUCATION_IMAGE_VERSION

    podman run --cap-add AUDIT_WRITE -e VM_IP=$VM_IP -e ANSIBLE_EDU_ENV=$ANSIBLE_EDU_ENV -e SSH_PORT=$ANSIBLE_EDU_NODE02_PORT --network $ANSIBLE_EDU_ENV -p $ANSIBLE_EDU_NODE02_PORT:22 -idt --name $ANSIBLE_EDU_ENV-node02 docker.io/milkliver/ansible-education-node02-container:$EDUCATION_IMAGE_VERSION

    echo "podman exec -it $ANSIBLE_EDU_ENV-controller bash" >$ANSIBLE_EDU_CONNECT_SHELL_DIR/ansible-edu-$ANSIBLE_EDU_ENV

    chmod +x $ANSIBLE_EDU_CONNECT_SHELL_DIR/ansible-edu-$ANSIBLE_EDU_ENV

    echo "create $ANSIBLE_EDU_ENV env success"

done
