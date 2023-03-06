#!/bin/bash
echo "$VM_IP node01 node02 controller" >>/etc/hosts

echo "Student = $ANSIBLE_EDU_ENV" >>/etc/motd
echo "Node = controller" >>/etc/motd

# --------------------
cat <<EOF >/workspace/ansible.cfg
[defaults]
inventory=./inventory
ask_pass=false
private_key_file=/workspace/id_rsa

[privilege_escalation]
become=false
become_method=sudo
become_user=root
become_ask_pass=false
EOF

# --------------------
cat <<EOF >/workspace/inventory
[ansible_node01]
node01

[ansible_node02]
node02

[ansible_node01:vars]
ansible_user=node01
ansible_port=$ANSIBLE_EDU_NODE01_PORT

[ansible_node02:vars]
ansible_user=node02
ansible_port=$ANSIBLE_EDU_NODE02_PORT
EOF
# --------------------

export $ANSIBLE_EDU_NODE01_PORT

tail -f /dev/null
