# common environmnet configuration for these scripts

prepare_env () {
  set_versions
  product_slugs

  BOSH_URI=urn:x-pcf:bosh.azure.crdant.io
  APPLICATION_ID=aa0b92b9-248d-4edd-bf8e-811dd765335b
  RESOURCE_GROUP=pcf-installation
  STORAGE_NAME="boshcrdantio"
  PCF_STORAGE_NAME="pcfcrdantio"

  BASE_STORAGE_NAME="xtrastrgtimzncgeuuuca"
  OPS_MAN_IMAGE_URL="https://opsmanagereastus.blob.core.windows.net/images/ops-manager-1.10.1.vhd"

  DOMAIN_TOKEN=`echo ${DOMAIN} | tr . -`
  SUBDOMAIN="azure.${DOMAIN}"
  SUBDOMAIN_TOKEN=`echo ${SUBDOMAIN} | tr . -`

  LOCATION=eastus

  # TODO: refactor these to match refarch
  NETWORK="pcf-net"
  SUBNET="pcf"
  DEFAULT_SECURITY_GROUP="pcf-nsg"
  # end TODO

  DNS_ZONE="${SUBDOMAIN}"
  DNS_TTL=60

  DNS_ZONE=`echo ${SUBDOMAIN} | tr . -`
  DNS_TTL=60
  CIDR="10.0.0.0/20"
  ALL_INTERNET="0.0.0.0/0"
  KEYDIR="${BASEDIR}/keys"
  WORKDIR="${BASEDIR}/work"
  PASSWORD_LIST="${KEYDIR}/password-list"
  ENV_OUTPUTS="${WORKDIR}/installed-env.sh"

  INFRASTRUCTURE_CIDR="10.0.0.0/26"
  INFRASTRUCTURE_RESERVED="10.0.0.1"
  INFRASTRUCTURE_GATEWAY="10.0.0.1-10.0.0.10"
  DEPLOYMENT_CIDR="10.1.0.0/22"
  DEPLOYMENT_RESERVED="10.1.0.1"
  DEPLOYMENT_GATEWAY="10.1.0.1-10.1.0.9"
  TILES_CIDR="10.2.0.0/22"
  TILES_RESERVED="10.2.0.1"
  TILES_GATEWAY="10.2.0.1-10.2.0.9"
  SERVICES_CIDR="10.3.0.0/22"
  SERVICES_RESERVED="10.3.0.1"
  SERVICES_GATEWAY="10.3.0.1-10.3.0.9"

  PCF_SYSTEM_DOMAIN=system.${SUBDOMAIN}
  PCF_APPS_DOMAIN=apps.${SUBDOMAIN}
  OPS_MANAGER_HOST="manager"
  OPS_MANAGER_FQDN="${OPS_MANAGER_HOST}.${SUBDOMAIN}"
  OPS_MANAGER_API_ENDPOINT="https://${OPS_MANAGER_FQDN}/api/v0"
  INFRASTRUCTURE_NETWORK_NAME="gcp-${REGION_1}-infrastructure"
  DEPLOYMENT_NETWORK_NAME="gcp-${REGION_1}-deployment"
  TILES_NETWORK_NAME="gcp-${REGION_1}-tiles"
  SERVICE_NETWORK_NAME="gcp-${REGION_1}-services"

  BUILDPACKS_STORAGE_BUCKET="buildpacks-pcf-${SUBDOMAIN_TOKEN}"
  DROPLETS_STORAGE_BUCKET="droplets-pcf-${SUBDOMAIN_TOKEN}"
  PACKAGES_STORAGE_BUCKET="packages-pcf-${SUBDOMAIN_TOKEN}"
  RESOURCES_STORAGE_BUCKET="resources-pcf-${SUBDOMAIN_TOKEN}"

  SSH_LOAD_BALANCER_NAME="pcf-ssh-${SUBDOMAIN_TOKEN}"
  HTTP_LOAD_BALANCER_NAME="pcf-http-router-${SUBDOMAIN_TOKEN}"
  WS_LOAD_BALANCER_NAME="pcf-websockets-${SUBDOMAIN_TOKEN}"
  TCP_LOAD_BALANCER_NAME="pcf-tcp-router-${SUBDOMAIN_TOKEN}"

  BROKER_DB_USER="pcf"

  # set variables for passwords if they are available
  if [ -e ${PASSWORD_LIST} ] ; then
    . ${PASSWORD_LIST}
  fi

  # set variables for various created elements
  if [ -e "${ENV_OUTPUTS}" ] ; then
    . ${ENV_OUTPUTS}
  fi
}

set_versions () {
  OPS_MANAGER_VERSION="1.11.0"
  OPS_MANAGER_VERSION_TOKEN=`echo ${OPS_MANAGER_VERSION} | tr . -`
  PCF_VERSION="1.11.0"
  STEMCELL_VERSION="3421.3"
  MYSQL_VERSION="1.9.4"
  RABBIT_VERSION="1.8.8"
  REDIS_VERSION="1.8.2"
  PCC_VERSION="1.0.4"
  SCS_VERSION="1.4.0"
  SERVICE_BROKER_VERSION="1.2.3"
  SERVICE_BROKER_VERSION_TOKEN=`echo ${SERVICE_BROKER_VERSION} | tr . - | tr ' ' - | tr -d ')' | tr -d '(' | tr '[:upper:]' '[:lower:]'`
  WINDOWS_VERSION="1.11.0"
  ISOLATION_VERSION="1.11.0"
  IPSEC_VERSION="1.6.3"
  PUSH_VERSION="1.9.0"
  SSO_VERSION="1.4.1"
  SCHEDULER_VERSION="1.0.2-beta"
}

product_slugs () {
  PCF_SLUG="elastic-runtime"
  PCF_OPSMAN_SLUG="cf"
  OPS_MANAGER_SLUG="ops-manager"
  MYSQL_SLUG="p-mysql"
  REDIS_SLUG="p-redis"
  RABBIT_SLUG="p-rabbitmq"
  SERVICE_BROKER_SLUG="microsoft-azure-service-broker"
  SCS_SLUG="p-spring-cloud-services"
  PCC_SLUG="cloud-cache"
  PUSH_SLUG="push-notification-service"
  SSO_SLUG="p-identity"
  IPSEC_SLUG="p-ipsec-addon"
  ISOLATION_SLUG="isolation-segment"
  SCHEDULER_SLUG="p-scheduler-for-pcf"
  WINDOWS_SLUG="runtime-for-windows"
}


store_var () {
  set -x
  variable="${1}"
  value="${2}"

  if [ -z "${value}" ] ; then
    code="echo \$${variable}"
    value=`eval $code`
  fi

  eval "$variable=${value}"
  echo "$variable=${value}" >> "${ENV_OUTPUTS}"
  set +x
}

store_json_var () {
  json="${1}"
  variable="${2}"
  jspath="${3}"

  value=`echo "${json}" | jq --raw-output "${jspath}"`
  store_var ${variable} ${value}
}

set_versions () {
  OPS_MANAGER_VERSION="1.10.1"
  OPS_MANAGER_VERSION_TOKEN=`echo ${OPS_MANAGER_VERSION} | tr . -`
  PCF_VERSION="1.10.1"
  STEMCELL_VERSION="3263.20"
  MYSQL_VERSION="1.8.5"
  RABBIT_VERSION="1.8.0-Alpha-207"
  REDIS_VERSION="1.8.0.beta.102"
  PCC_VERSION="1.0.0"
  SCS_VERSION="1.3.4"
  CONCOURSE_VERSION="1.0.0-edge.11"
  IPSEC_VERSION="1.5.37"
  PUSH_VERSION="1.8.1"
  SSO_VERSION="1.3.1"
  ISOLATION_VERSION="1.10.1"
}
