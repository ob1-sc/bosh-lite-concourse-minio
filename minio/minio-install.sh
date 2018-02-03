#!/usr/bin/env bash

BOSH_CLI_NAME=bosh

# clone the concourse-deployment repository
rm -rf minio-boshrelease
git clone https://github.com/minio/minio-boshrelease.git

pushd minio-boshrelease

# get the required stemcell version
STEMCELL_VERSION=$($BOSH_CLI_NAME int manifest-fs-example.yml --path /stemcells/alias=default/version)
STEMCELL_URL=https://bosh.io/d/stemcells/bosh-warden-boshlite-ubuntu-trusty-go_agent

# if the stemcell isn't latest then append version number to the URL
if [[ $STEMCELL_VERSION != "latest" ]]; then
  $STEMCELL_URL = $STEMCELL_URL + "?v=" + $STEMCELL_VERSION
fi

# upload the stemcell
$BOSH_CLI_NAME upload-stemcell $STEMCELL_URL -n

# install the cloud config
$BOSH_CLI_NAME update-cloud-config cloud_configs/vbox.yml -n



# update the cloud config for vbox
$BOSH_CLI_NAME update-cloud-config cloud_configs/vbox.yml -n



  popd
