#!/bin/bash

POSTINSTALL_DIR=scripts/postinstall

sudo apt update
sudo apt-get update

${POSTINSTALL_DIR}/bashrc-update.sh
${POSTINSTALL_DIR}/other.sh
${POSTINSTALL_DIR}/docker-install.sh
${POSTINSTALL_DIR}/k8s-install.sh


