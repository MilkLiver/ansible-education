#!/bin/bash
echo "$VM_IP node01 node02 controller" >>/etc/hosts

echo "Student = $ANSIBLE_EDU_ENV" >>/etc/motd
echo "Node = node02" >>/etc/motd

#/usr/sbin/sshd -Dp 22
exec /usr/sbin/init
