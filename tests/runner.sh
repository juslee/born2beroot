#!/bin/bash
apt install -y curl
curl https://assert.specs.sh/install.sh | bash
./mandatory/hostname.sh
apt purge -y curl
