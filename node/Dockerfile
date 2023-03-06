FROM registry.redhat.io/ubi8/ubi:latest
ARG UID=0
ARG GID=0

RUN mkdir -p /opt/sshd
COPY ./startup.sh /opt/sshd/

RUN chmod +x /opt/sshd/startup.sh

# update
RUN dnf update -y

RUN dnf -y install openssh-server openssh-clients net-tools sudo

RUN ssh-keygen -A
RUN sed -i 's/^UsePAM yes$/UsePAM no/' /etc/ssh/sshd_config

RUN echo "root:Admin12345" | chpasswd

RUN useradd -u 1000 -m student
RUN echo "student:student" | chpasswd
RUN usermod -aG wheel student

# Instsall python3.8
# RUN dnf module -y install python38

# Set python3 version to 3.8
# RUN alternatives --set python3 /usr/bin/python3.8
ENTRYPOINT ["/opt/sshd/startup.sh"]
