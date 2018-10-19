#!/bin/bash -eux

mv /tmp/sudoers-ssh-forward-agent /etc/sudoers.d/
chmod 0440 /etc/sudoers.d/sudoers-ssh-forward-agent
chown root:root /etc/sudoers.d/sudoers-ssh-forward-agent
