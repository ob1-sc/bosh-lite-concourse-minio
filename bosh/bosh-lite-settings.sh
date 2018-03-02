#!/usr/bin/env bash

BOSH_LITE_ENV_ALIAS=vbox

pushd ~/deployments

# clone the bosh-lite repository
rm -rf bosh-lite
git clone https://github.com/cloudfoundry/bosh-lite.git

# set the bosh-lite director clent/secret
echo export BOSH_CLIENT=admin >> /home/vagrant/.profile
echo export BOSH_CLIENT_SECRET=admin >> /home/vagrant/.profile

# alias the bosh-lite director environment
bosh -e 192.168.50.4 --ca-cert <(cat bosh-lite/ca/certs/ca.crt) alias-env $BOSH_LITE_ENV_ALIAS

# get the name of the bosh-lite environment alias
echo export BOSH_ENVIRONMENT=$BOSH_LITE_ENV_ALIAS >> /home/vagrant/.profile

popd
