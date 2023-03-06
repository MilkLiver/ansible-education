FROM registry.redhat.io/ubi8/ubi:latest

# update
RUN dnf update -y

# Instsall python3.8
RUN dnf module -y install python38

# Set python3 version to 3.8
RUN alternatives --set python3 /usr/bin/python3.8

# Update pip3
RUN pip3 install --upgrade pip

# Install ansible
RUN pip3 install ansible argcomplete

# Install python module winrm
RUN pip3 install pywinrm

# Install ansible.windows
RUN ansible-galaxy collection install ansible.windows

# Install openssh-clients
RUN dnf install openssh-clients -y

# Installing the Kubernetes Collection for Ansible
## Install the OpenShift python client package
RUN pip3 install openshift

## Installing the Kubernetes Python Library
RUN pip3 install kubernetes

## install the collection directly from Ansible Galaxy:
RUN ansible-galaxy collection install kubernetes.core

## install openshift collection
RUN ansible-galaxy collection install community.okd

ENTRYPOINT ["tail", "-f", "/dev/null"]
