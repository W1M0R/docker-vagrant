#!/bin/bash
echo "Installing system updates as user '$(whoami)'."
export DEBIAN_FRONTEND=noninteractive
sudo -E apt-get update
sudo -E apt-get upgrade -y -qq
