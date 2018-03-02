#!/usr/bin/env bash

BOSH_CLI_NAME=bosh
MINIO_MANIFEST=manifest-fs-example.yml

pushd ~/deployments

# clone the minio-boshrelease repository
rm -rf minio-boshrelease
git clone https://github.com/minio/minio-boshrelease.git

pushd minio-boshrelease/manifests

# get the required stemcell version
STEMCELL_VERSION=$($BOSH_CLI_NAME int $MINIO_MANIFEST --path /stemcells/alias=default/version)
STEMCELL_URL=https://bosh.io/d/stemcells/bosh-warden-boshlite-ubuntu-trusty-go_agent

# if the stemcell isn't latest then append version number to the URL
if [[ $STEMCELL_VERSION != "latest" ]]; then
  $STEMCELL_URL = $STEMCELL_URL + "?v=" + $STEMCELL_VERSION
fi

# upload the stemcell
$BOSH_CLI_NAME upload-stemcell $STEMCELL_URL -n

# patch the OOTB minio manifest to set the network
cat $MINIO_MANIFEST | yaml-patch -o /vagrant/minio/manifest-patch.yml > minio.yml

# upload the minio boshrelease
$BOSH_CLI_NAME upload-release https://bosh.io/d/github.com/minio/minio-boshrelease

# deploy minio
$BOSH_CLI_NAME deploy -d minio minio.yml -n

popd

popd
