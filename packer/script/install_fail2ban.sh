#!/bin/bash -eux

apt -y update
apt -y install fail2ban

mv /tmp/jail.local /etc/fail2ban/jail.local
chmod 644 /etc/fail2ban/jail.local
chown root:root /etc/fail2ban/jail.local
