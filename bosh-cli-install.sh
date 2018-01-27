#!/usr/bin/env bash

BOSH_HREF=https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-2.0.48-linux-amd64
BOSH_CLI_NAME=bosh

# download bosh
wget -O $BOSH_CLI_NAME $BOSH_HREF

# make executable
chmod +x $BOSH_CLI_NAME

# move to local bin
mv $BOSH_CLI_NAME /usr/local/bin/$BOSH_CLI_NAME

# print bosh version
$BOSH_CLI_NAME -v
