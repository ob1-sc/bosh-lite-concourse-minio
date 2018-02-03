#!/usr/bin/env bash

BOSH_CLI_NAME=bosh

pushd /vagrant

# update the cloud config for bosh-lite
$BOSH_CLI_NAME update-cloud-config cloud-config/bosh-lite.yml -n

popd
