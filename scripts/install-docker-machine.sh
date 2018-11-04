#!/bin/bash
echo "Installing docker-machine as user '$(whoami)'."
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source $SCRIPT_DIR/functions.sh
VERSION=$(find_github_repo_latest_release docker/machine)
echo "Latest version is $VERSION."
echo "Downloading docker-machine $VERSION."
curl --silent -L https://github.com/docker/machine/releases/download/$VERSION/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine
echo "Installing docker-machine $VERSION."
chmod +x /tmp/docker-machine
sudo cp /tmp/docker-machine /usr/local/bin/docker-machine
docker-machine version