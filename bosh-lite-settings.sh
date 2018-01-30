#!/usr/bin/env bash

BOSH_LITE_ENV_ALIAS=vbox

# clone the bosh-lite repository
git clone https://github.com/cloudfoundry/bosh-lite.git

# set the bosh-lite director clent/secret
echo export BOSH_CLIENT=admin >> .bashrc
echo export BOSH_CLIENT_SECRET=admin >> .bashrc

# alias the bosh-lite director environment
bosh -e 192.168.50.4 --ca-cert <(cat bosh-lite/ca/certs/ca.crt) alias-env $BOSH_LITE_ENV_ALIAS

# get the name of the bosh-lite environment alias
echo export BOSH_ENVIRONMENT=$BOSH_LITE_ENV_ALIAS >> .bashrc
