# make the environment for these scripts available in your current shell
if [ -n "$ZSH_VERSION" ]; then
  BASEDIR=`dirname ${(%):-%N}`
elif [ -n "$BASH_VERSION" ]; then
  BASEDIR=`dirname ${BASH_SOURCE[0]}`
else
  # doesn't likely work but it's something to set it as
  BASEDIR=`dirname $0`
fi

GCPDIR=${HOME}/workspace/pcf-on-gcp

. "${BASEDIR}/lib/env.sh"
. "${BASEDIR}/personal.sh"
. "${GCPDIR}/lib/login_ops_manager.sh"
. "${BASEDIR}/lib/ops_manager.sh"
. "${BASEDIR}/lib/director.sh"
. "${BASEDIR}/lib/ssl_keys.sh"
. "${GCPDIR}/lib/eula.sh"
. "${GCPDIR}/lib/products.sh"
. "${GCPDIR}/lib/guid.sh"
. "${GCPDIR}/lib/networks_azs.sh"
. "${GCPDIR}/lib/properties.sh"
. "${GCPDIR}/lib/resources.sh"
. "${GCPDIR}/lib/credentials.sh"

prepare_env
set_versions

# Cloud
export SUBSCRIPTION_ID
export TENANT_ID
export RESOURCE_GROUP
export DOMAIN
export EMAIL

export LOCATION

# DNS
export SUBDOMAIN
export DNS_ZONE
export DNS_TTL

# Network
export CIDR
export SERVICES_CIDR
export ALL_INTERNET
export DNS_SERVERS
export DEFAULT_SECURITY_GROUP

export NETWORK
export SUBNET
export DIRECTOR_NETWORK_NAME

# Configuration
export KEYDIR
export WORKDIR
export PASSWORD_LIST

export STORAGE_NAME
export BASE_STORAGE_NAME
export PCF_STORAGE_NAME
export OSP_MAN_IMAGE_URL
export CONNECTION_STRING_1
export CONNECTION_STRING_2
export CONNECTION_STRING_3
export PCF_CONNECTION_STRING

export PCF_SYSTEM_DOMAIN
export PCF_APPS_DOMAIN
export OPS_MANAGER_HOST
export OPS_MANAGER_FQDN
export OPS_MANAGER_API_ENDPOINT

export STORAGE_NAME

# versions
export OPS_MANAGER_VERSION
export OPS_MANAGER_VERSION_TOKEN
export PCF_VERSION
export STEMCELL_VERSION
export MYSQL_VERSION
export RABBIT_VERSION
export REDIS_VERSION
export AZURE_VERSION
export AZURE_VERSION_NUM
export SCS_VERSION
export PCC_VERSION
export CONCOURSE_VERSION
export IPSEC_VERSION
export PUSH_VERSION

# secrets
export ADMIN_PASSWORD
export DECRYPTION_PASSPHRASE
export BROKER_SECRET
export CLIENT_SECRET
export CONNECTION_STRING
export CONNECTION_STRING_1
export CONNECTION_STRING_2
export CONNECTION_STRING_3
export PCF_CONNECTION_STRING
