FROM registry.redhat.io/ubi8/ubi:latest
ARG UID=0
ARG GID=0

# ---------- dnf install ----------
# update
RUN dnf update -y
RUN dnf -y install openssh-server openssh-clients net-tools sudo

# Instsall python3.8
# RUN dnf module -y install python38

# Set python3 version to 3.8
# RUN alternatives --set python3 /usr/bin/python3.8

# ---------- init shell ----------
RUN mkdir -p /opt/init
COPY ./startup.sh /opt/init/
RUN chmod +x /opt/init/startup.sh

# ---------- sshd settings ----------
# create keys for sshd
RUN ssh-keygen -A
# disable sshd config UsePAM setting
RUN sed -i 's/^UsePAM yes$/UsePAM no/' /etc/ssh/sshd_config

# ---------- user settings ----------
# change root password
RUN echo "root:Admin12345" | chpasswd

# create user student
RUN useradd -u 1000 -m node01
RUN echo "node01:node01" | chpasswd
RUN usermod -aG wheel node01

COPY ./node01 /etc/sudoers.d/

# ---------- init ----------
RUN mkdir /workspace
WORKDIR /workspace

ENTRYPOINT ["/opt/init/startup.sh"]
