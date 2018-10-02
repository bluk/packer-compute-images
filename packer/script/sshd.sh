#!/bin/bash -eux

mv /tmp/sshd_config /etc/ssh/sshd_config
chmod 644 /etc/ssh/sshd_config

awk '$5 > 2000' /etc/ssh/moduli > "${HOME}/moduli"
wc -l "${HOME}/moduli" # make sure there is something left
mv "${HOME}/moduli" /etc/ssh/moduli

mv /tmp/sudoers-ssh-forward-agent /etc/sudoers.d/
chmod 0440 /etc/sudoers.d/sudoers-ssh-forward-agent
chown root:root /etc/sudoers.d/sudoers-ssh-forward-agent
