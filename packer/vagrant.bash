#!/bin/bash

set -euxo pipefail

vagrant box remove ubuntu1804 --provider virtualbox || true
vagrant box add ubuntu1804 box/virtualbox/ubuntu1804-0.1.0.box || true
vagrant box remove ubuntu1804 --provider vmware_desktop || true
vagrant box add ubuntu1804 box/vmware/ubuntu1804-0.1.0.box
