#!/usr/bin/env bash

CONCOURSE_IP=10.244.15.2
BOSH_CLI_NAME=bosh

# clone the concourse-deployment repository
rm -rf concourse-deployment
git clone https://github.com/concourse/concourse-deployment.git

pushd concourse-deployment/cluster

# get the required stemcell version
STEMCELL_VERSION=$($BOSH_CLI_NAME int concourse.yml --path /stemcells/alias=trusty/version)
STEMCELL_URL=https://bosh.io/d/stemcells/bosh-warden-boshlite-ubuntu-trusty-go_agent

# if the stemcell isn't latest then append version number to the URL
if [[ $STEMCELL_VERSION != "latest" ]]; then
  $STEMCELL_URL = $STEMCELL_URL + "?v=" + $STEMCELL_VERSION
fi

# upload the stemcell
$BOSH_CLI_NAME upload-stemcell $STEMCELL_URL -n

# update the cloud config for vbox
# $BOSH_CLI_NAME update-cloud-config cloud_configs/vbox.yml -n

# deploy concourse
$BOSH_CLI_NAME deploy -d concourse concourse.yml -n \
  -l ../versions.yml \
  --vars-store cluster-creds.yml \
  -o operations/static-web.yml \
  -o operations/no-auth.yml \
  --var web_ip=$CONCOURSE_IP \
  --var external_url=http://$CONCOURSE_IP:8080 \
  --var network_name=bosh-lite \
  --var web_vm_type=default \
  --var db_vm_type=default \
  --var db_persistent_disk_type=default \
  --var worker_vm_type=default \
  --var deployment_name=concourse

  popd
