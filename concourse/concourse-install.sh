#!/usr/bin/env bash

CONCOURSE_IP=10.244.15.2
BOSH_CLI_NAME=bosh
CONCOURSE_MANIFEST=concourse.yml

pushd ~/deployments

# clone the concourse-deployment repository
rm -rf concourse-deployment
git clone https://github.com/concourse/concourse-deployment.git

pushd concourse-deployment/cluster

# patch the OOTB concourse manifest to set the stemcell
# fix for https://github.com/concourse/concourse-deployment/issues/46
mv $CONCOURSE_MANIFEST $CONCOURSE_MANIFEST.old
cat $CONCOURSE_MANIFEST.old | yaml-patch -o /vagrant/concourse/manifest-patch.yml > $CONCOURSE_MANIFEST

# get the required stemcell version
STEMCELL_VERSION=$($BOSH_CLI_NAME int $CONCOURSE_MANIFEST --path /stemcells/alias=trusty/version)
STEMCELL_URL="https://bosh.io/d/stemcells/bosh-warden-boshlite-ubuntu-trusty-go_agent"

# if the stemcell isn't latest then append version number to the URL
if [[ $STEMCELL_VERSION != "latest" ]]; then
  STEMCELL_URL="$STEMCELL_URL?v=$STEMCELL_VERSION"
fi

# upload the stemcell
$BOSH_CLI_NAME upload-stemcell $STEMCELL_URL -n

# deploy concourse
$BOSH_CLI_NAME deploy -d concourse $CONCOURSE_MANIFEST -n \
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

popd
