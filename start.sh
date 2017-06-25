#!/usr/bin/env bash
# start instances running at the IaaS level

BASEDIR=`dirname $0`
GCPDIR="${BASEDIR}/../pcf-on-gcp"
. "${BASEDIR}/lib/env.sh"
. "${BASEDIR}/personal.sh"
. "${GCPDIR}/lib/login_ops_manager.sh"
. "${GCPDIR}/lib/ops_manager.sh"

vms () {
  # start bosh managed VMs
  for instance in `az vm list --resource-group $RESOURCE_GROUP | jq --raw-output '. [] | select ( .tags.director == "p-bosh" ) .name'`; do
      az vm start --resource-group ${RESOURCE_GROUP} --name "${instance}" &
  done
}

ops_manager () {
  # start Ops Manager
  for instance in `az vm list --resource-group $RESOURCE_GROUP | jq --raw-output '. [] | select ( .tags.director == null ) .name'`; do
    az vm start --resource-group ${RESOURCE_GROUP} --name "${instance}" &
  done
  sleep 120
  unlock_ops_manager
}

director () {
  # start BOSH director
  for instance in `az vm list --resource-group $RESOURCE_GROUP | jq --raw-output '. [] | select ( .tags.director == "bosh-init" ) .name'`; do
      az vm start --resource-group ${RESOURCE_GROUP} --name "${instance}" &
  done
}

prepare_env
ops_manager
director
vms
