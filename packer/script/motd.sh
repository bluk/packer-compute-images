#!/bin/bash -eux

# Original file:
# https://github.com/boxcutter/ubuntu/blob/8588a552cd63f6e0966f8c713589a0ee3736dc77/script/motd.sh
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

echo "==> Recording box generation date"
date > /etc/vagrant_box_build_date

echo "==> Customizing message of the day"
MOTD_FILE=/etc/motd
BANNER_WIDTH=64
PLATFORM_RELEASE=$(lsb_release -sd)
PLATFORM_MSG=$(printf '%s' "$PLATFORM_RELEASE")
BUILT_MSG=$(printf 'built %s' $(date +%Y-%m-%d))
printf '%0.1s' "-"{1..64} > ${MOTD_FILE}
printf '\n' >> ${MOTD_FILE}
printf '%2s%-30s%30s\n' " " "${PLATFORM_MSG}" "${BUILT_MSG}" >> ${MOTD_FILE}
printf '%0.1s' "-"{1..64} >> ${MOTD_FILE}
printf '\n' >> ${MOTD_FILE}
