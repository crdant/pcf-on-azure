#!/usr/bin/env bash
# stop running instances at the IaaS level

BASEDIR=`dirname $0`
. "${BASEDIR}/lib/env.sh"
. "${BASEDIR}/personal.sh"

vms () {
  # start bosh managed VMs
  for instance in `az vm list --resource-group $RESOURCE_GROUP | jq --raw-output '. [] | select ( .tags.director == "p-bosh" ) .name'`; do
      az vm stop --resource-group ${RESOURCE_GROUP} --name "${instance}"  &
  done
}

ops_manager () {
  # start Ops Manager
  for instance in `az vm list --resource-group $RESOURCE_GROUP | jq --raw-output '. [] | select ( .tags.director == null ) .name'`; do
    az vm stop --resource-group ${RESOURCE_GROUP} --name "${instance}" &
  done
}

director () {
  # start BOSH director
  for instance in `az vm list --resource-group $RESOURCE_GROUP | jq --raw-output '. [] | select ( .tags.director == "bosh-init" ) .name'`; do
      az vm stop --resource-group ${RESOURCE_GROUP} --name "${instance}" &
  done
}

prepare_env
ops_manager
director
vms
