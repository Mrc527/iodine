#!/bin/sh

# [ global parameters ]
# certificate configuration
readonly CERT_DAYS=36500
readonly RSA_STR_LEN=4096
readonly PREFIX=iodine-
readonly CERT_DIR=/etc/ssl
readonly KEY_DIR=/etc/ssl/private
# certificate content definition
readonly ADDRESS_COUNTRY_CODE=IT
readonly ADDRESS_PREFECTURE=XX
readonly ADDRESS_CITY=XXXX
readonly COMPANY_NAME=XXXXXXXX
readonly COMPANY_SECTION=XXXXXXXX
readonly CERT_PASSWORD= # no password
# - ca
readonly CA_DOMAIN=x.domain
readonly CA_EMAIL=ca@email.address
# - server
readonly SERVER_DOMAIN=y.domain
readonly SERVER_EMAIL=server@email.address
# - client
readonly CLIENT_DOMAIN=z.domain
readonly CLIENT_EMAIL=client@email.address

# [ functions ]
echo_cert_params() {
    local company_domain="$1"
    local company_email="$2"

    echo $ADDRESS_COUNTRY_CODE
    echo $ADDRESS_PREFECTURE
    echo $ADDRESS_CITY
    echo $COMPANY_NAME
    echo $COMPANY_SECTION
    echo $company_domain
    echo $company_email
    echo $CERT_PASSWORD     # password
    echo $CERT_PASSWORD     # password (again)
}
echo_ca_cert_params() {
    echo_cert_params "$CA_DOMAIN" "$CA_EMAIL"
}
echo_server_cert_params() {
    echo_cert_params "$SERVER_DOMAIN" "$SERVER_EMAIL"
}
echo_client_cert_params() {
    echo_cert_params "$CLIENT_DOMAIN" "$CLIENT_EMAIL"
}

# [ main ]
# generate certificates
# - ca
echo_ca_cert_params | \
    #openssl req -new -x509 -nodes -days $CERT_DAYS -key $KEY_DIR/${PREFIX}ca-key.pem -out $CERT_DIR/${PREFIX}ca-cert.pem
    openssl req -new -newkey rsa:2048 -days $CERT_DAYS -nodes -x509 -keyout $CERT_DIR/${PREFIX}ca-cert.pem -out $CERT_DIR/${PREFIX}ca-cert.pem
