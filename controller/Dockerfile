FROM registry.redhat.io/ubi8/ubi:latest
ARG UID=0
ARG GID=0

# ---------- dnf install ----------
# update
RUN dnf update -y
RUN dnf -y install openssh-server openssh-clients net-tools sudo
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

# ---------- pip install ----------
# Install the OpenShift python client package
RUN pip3 install openshift
# Installing the Kubernetes Python Library
RUN pip3 install kubernetes
# install the collection directly from Ansible Galaxy:
RUN ansible-galaxy collection install kubernetes.core
# install openshift collection
RUN ansible-galaxy collection install community.okd

# ---------- init ----------
RUN mkdir /workspace
WORKDIR /workspace

RUN mkdir /sample
COPY ./ansible.cfg /sample/ansible.cfg
RUN ssh-keygen -t rsa -b 4096 -N '' -f /sample/id_rsa

RUN mkdir -p /opt/init
COPY ./startup.sh /opt/init/
RUN chmod +x /opt/init/startup.sh

# ---------- user settings ----------
# change root password
RUN echo "root:Admin12345" | chpasswd

ENTRYPOINT ["/opt/init/startup.sh"]
