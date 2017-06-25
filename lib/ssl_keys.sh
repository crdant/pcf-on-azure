self_signed_certificate () {
  certificate_request
  sign_certificate
}

certificate_request () {
  openssl req -new -sha256 -nodes -out "${KEYDIR}/${SUBDOMAIN}.csr" -newkey rsa:2048 -keyout "${KEYDIR}/${SUBDOMAIN}.key" -config <(
  cat <<-EOF
  [req]
  default_bits = 2048
  prompt = no
  default_md = sha256
  req_extensions = req_ext
  distinguished_name = dn

  [ dn ]
  C=US
  ST=Massachusetts
  L=Cambridge
  O=Cloud Foundry
  OU=Azure Deployment
  emailAddress=${EMAIL}
  CN = *.${SUBDOMAIN}

  [ req_ext ]
  subjectAltName = @alt_names

  [ alt_names ]
  DNS.1 = *.${PCF_APPS_DOMAIN}
  DNS.2 = *.${PCF_SYSTEM_DOMAIN}
  DNS.3 = *.login.${PCF_SYSTEM_DOMAIN}
  DNS.4 = *.uaa.${PCF_SYSTEM_DOMAIN}
EOF
  )
}

sign_certificate () {
  openssl x509 -req -sha256 -days 3650 -in "${KEYDIR}/${SUBDOMAIN}.csr" -signkey "${KEYDIR}/${SUBDOMAIN}.key" -out "${KEYDIR}/${SUBDOMAIN}.crt"
}
