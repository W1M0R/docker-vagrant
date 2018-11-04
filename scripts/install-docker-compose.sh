#!/bin/bash
echo "Installing docker-compose as user '$(whoami)'."
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source $SCRIPT_DIR/functions.sh
VERSION=$(find_github_repo_latest_release docker/compose)
echo "Latest version is $VERSION."
echo "Downloading docker-compose $VERSION."
curl --silent -L https://github.com/docker/compose/releases/download/$VERSION/docker-compose-`uname -s`-`uname -m` >/tmp/docker-compose
echo "Installing docker-compose $VERSION."
chmod +x /tmp/docker-compose
sudo cp /tmp/docker-compose /usr/local/bin/docker-compose
docker-compose version