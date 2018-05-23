#!/bin/bash

# Install dependencies
echo "========== Update Aptitude ==========="
sudo apt-get update
sudo apt-get upgrade -yq
sudo apt-get install -y mpg123 python-serial

echo "/home/linaro/workspace/AiVA-Cert-SW/menu.sh" | tee -a ~/.bashrc
source ~/.bashrc

chmod +x *.sh