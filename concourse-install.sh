#!/usr/bin/env bash

CONCOURSE_IP=10.244.15.2

# clone the concourse-deployment repository
git clone https://github.com/concourse/concourse-deployment.git

pushd concourse-deployment/cluster

# get the required stemcell version
STEMCELL_VERSION=$(bosh int concourse.yml --path /stemcells/alias=trusty/version)
STEMCELL_URL=https://bosh.io/d/stemcells/bosh-warden-boshlite-ubuntu-trusty-go_agent

# if the stemcell isn't latest then append version number to the URL
if [[ $STEMCELL_VERSION != "latest" ]]; then
  $STEMCELL_URL = $STEMCELL_URL + "?v=" + $STEMCELL_VERSION
fi

# upload the stemcell
bosh upload-stemcell $STEMCELL_URL

# update the cloud config for vbox
bosh -e $BOSH_ENVIRONMENT update-cloud-config cloud_configs/vbox.yml

# deploy concourse
bosh -e $BOSH_ENVIRONMENT deploy -d concourse concourse.yml \
  -l ../versions.yml \
  --vars-store cluster-creds.yml \
  -o operations/static-web.yml \
  -o operations/no-auth.yml \
  --var web_ip=$CONCOURSE_IP \
  --var external_url=http://$CONCOURSE_IP:8080 \
  --var network_name=concourse \
  --var web_vm_type=concourse \
  --var db_vm_type=concourse \
  --var db_persistent_disk_type=db \
  --var worker_vm_type=concourse \
  --var deployment_name=concourse

  popd
