
prepare_env () {
  BOSH_URI=urn:x-pcf:bosh.azure.crdant.io
  APPLICATION_ID=aa0b92b9-248d-4edd-bf8e-811dd765335b
  RESOURCE_GROUP=pcf-installation

  LOCATION=eastus

  SUBDOMAIN="azure.${DOMAIN}"
  DNS_ZONE="${SUBDOMAIN}"
  CIDR="10.0.0.0/20"
  RESERVED_IP_RANGE="10.0.0.1-10.0.0.9"
  GATEWAY="10.0.0.1"
  ALL_INTERNET="0.0.0.0/0"
  DNS_SERVERS="8.8.8.8,8.8.4.4"
  NETWORK="pcf-net"
  SUBNET="pcf"
  DEFAULT_SECURITY_GROUP="pcf-nsg"

  DIRECTOR_NETWORK_NAME="default"

  KEYDIR="${BASEDIR}/keys"
  WORKDIR="${BASEDIR}/work"
  PASSWORD_LIST="${KEYDIR}/password-list"

  SSH_KEY_PATH="${KEYDIR}/opsman"

  STORAGE_NAME="boshcrdantio"
  BASE_STORAGE_NAME="xtrastrgtimzncgeuuuca"
  OPS_MAN_IMAGE_URL="https://opsmanagereastus.blob.core.windows.net/images/ops-manager-1.10.1.vhd"

  PCF_SYSTEM_DOMAIN="system.${SUBDOMAIN}"
  PCF_APPS_DOMAIN="apps.${SUBDOMAIN}"
  OPS_MANAGER_HOST="manager"
  OPS_MANAGER_FQDN="${OPS_MANAGER_HOST}.${SUBDOMAIN}"
  OPS_MANAGER_API_ENDPOINT="https://${OPS_MANAGER_FQDN}/api/v0"

  # set variables for passwords if they are available
  if [ -e ${PASSWORD_LIST} ] ; then
    . ${PASSWORD_LIST}
  fi
}
