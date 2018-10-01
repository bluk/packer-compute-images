#!/bin/bash -eux

# Original file:
# https://github.com/boxcutter/ubuntu/blob/8588a552cd63f6e0966f8c713589a0ee3736dc77/script/sshd.sh
#
# Copyright 2014 Box-Cutter Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

mv /tmp/sshd_config /etc/ssh/sshd_config
chmod 644 /etc/ssh/sshd_config

awk '$5 > 2000' /etc/ssh/moduli > "${HOME}/moduli"
wc -l "${HOME}/moduli" # make sure there is something left
mv "${HOME}/moduli" /etc/ssh/moduli

mv /tmp/sudoers-ssh-forward-agent /etc/sudoers.d/
chmod 0440 /etc/sudoers.d/sudoers-ssh-forward-agent
chown root:root /etc/sudoers.d/sudoers-ssh-forward-agent
