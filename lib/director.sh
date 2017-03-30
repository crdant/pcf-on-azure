set_director_config () {
  login_ops_manager
  SSH_PUBLIC_KEY=`cat ${SSH_KEY_PATH}.pub`
  SSH_PRIVATE_KEY=`cat ${SSH_KEY_PATH} | perl -pe 's#\n#\x5c\x5c\x6e#g'`

  CONFIG_JSON=`export SUBSCRIPTION_ID TENANT_ID APPLICATION_ID CLIENT_SECRET RESOURCE_GROUP STORAGE_NAME BASE_STORAGE_NAME DEFAULT_SECURITY_GROUP SSH_PUBLIC_KEY SSH_PRIVATE_KEY ; envsubst < api-calls/director/config.json ; unset SUBSCRIPTION_ID TENANT_ID APPLICATION_ID CLIENT_SECRET RESOURCE_GROUP STORAGE_NAME BASE_STORAGE_NAME DEFAULT_SECURITY_GROUP SSH_PUBLIC_KEY SSH_PRIVATE_KEY`
  curl -qsLf --insecure -X PUT "${OPS_MANAGER_API_ENDPOINT}/staged/director/properties" -H "Authorization: Bearer ${UAA_ACCESS_TOKEN}" -H "Content-Type: application/json" -d "${CONFIG_JSON}"
}

get_director_config () {
  login_ops_manager
  curl -qsLf --insecure "${OPS_MANAGER_API_ENDPOINT}/staged/director/properties" -H "Authorization: Bearer ${UAA_ACCESS_TOKEN}" -H "Accepts: application/json"
}

create_director_networks () {
  login_ops_manager
  NETWORKS_JSON=`export DIRECTOR_NETWORK_NAME RESOURCE_GROUP NETWORK SUBNET CIDR RESERVED_IP_RANGE GATEWAY DNS_SERVERS; envsubst < api-calls/director/create-networks.json; unset DIRECTOR_NETWORK_NAME RESOURCE_GROUP NETWORK SUBNET CIDR RESERVED_IP_RANGE GATEWAY DNS_SERVERS`
  curl --insecure -X PUT "${OPS_MANAGER_API_ENDPOINT}/staged/director/networks" -H "Authorization: Bearer ${UAA_ACCESS_TOKEN}" -H "Content-Type: application/json" -d "${NETWORKS_JSON}"
}

assign_director_networks () {
  login_ops_manager
  NETWORKS_JSON=`export DIRECTOR_NETWORK_NAME ; envsubst < api-calls/director/assign-networks.json; unset DIRECTOR_NETWORK_NAME`
  curl --insecure -X PUT "${OPS_MANAGER_API_ENDPOINT}/staged/director/network_and_az" -H "Authorization: Bearer ${UAA_ACCESS_TOKEN}" -H "Content-Type: application/json" -d "${NETWORKS_JSON}"
}
