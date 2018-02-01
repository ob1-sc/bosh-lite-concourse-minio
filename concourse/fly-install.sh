#!/usr/bin/env bash

CONCOURSE_IP=10.244.15.2
FLY_CLI_NAME=fly

# set the concourse IP in the fly download url
FLY_DOWNLOAD_URL="http://$CONCOURSE_IP:8080/api/v1/cli?arch=amd64&platform=linux"

# download fly from the concourse server
wget -O $FLY_CLI_NAME $FLY_DOWNLOAD_URL

# set perms
chmod +x $FLY_CLI_NAME

# move to bin
mv $FLY_CLI_NAME /usr/local/bin/$FLY_CLI_NAME

# print fly version
$FLY_CLI_NAME -v
