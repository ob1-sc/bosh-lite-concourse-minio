#!/usr/bin/env bash

BOSH_HREF=https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-2.0.48-linux-amd64
BOSH_CLI_NAME=bosh

# install bosh cli dependencies
apt-get update
apt-get install -y build-essential zlibc zlib1g-dev ruby ruby-dev openssl libxslt-dev libxml2-dev libssl-dev libreadline6 libreadline6-dev libyaml-dev libsqlite3-dev sqlite3

# download bosh
wget -O $BOSH_CLI_NAME $BOSH_HREF

# make executable
chmod +x $BOSH_CLI_NAME

# move to local bin
mv $BOSH_CLI_NAME /usr/local/bin/$BOSH_CLI_NAME

# print bosh version
$BOSH_CLI_NAME -v
