#!/usr/bin/env /bin/bash

set -euxo pipefail

vagrant box remove ubuntu1804 --provider virtualbox || true
vagrant box add ubuntu1804 box/virtualbox/ubuntu1804-0.1.0.box
