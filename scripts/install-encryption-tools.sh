#!/bin/bash
set -e

if [[ $EUID -eq 0 ]]; then
  echo "This script MUST NOT be run as root." 1>&2
  exit 1
fi

echo "Installing secret utils as $(whoami)."
sudo apt-get update
sudo apt-get install -y ecryptfs-utils
sudo apt-get autoremove -y
echo "Finished installing secret utils as $(whoami)."
