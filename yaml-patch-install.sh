#!/usr/bin/env bash

YAML_PATCH_CLI_NAME=yaml-patch
YAML_PATCH_VERSION=0.0.10
YAML_PATCH_DOWNLOAD_URL=https://github.com/krishicks/yaml-patch/releases/download/v$YAML_PATCH_VERSION/yaml_patch_linux

# download yaml-patch
wget -O $YAML_PATCH_CLI_NAME $YAML_PATCH_DOWNLOAD_URL

# set perms
chmod +x $YAML_PATCH_CLI_NAME

# move to bin
mv $YAML_PATCH_CLI_NAME /usr/local/bin/$YAML_PATCH_CLI_NAME
