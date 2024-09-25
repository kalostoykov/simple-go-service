#!/bin/bash

set -e

args=("$@")

if [ -z ${args[0]} ]; then
    echo "Credentials scope not set. Exiting..."
    exit 1
fi

if [ -z ${args[1]} ]; then
    echo "Credentials id not set. Exiting..."
    exit 1
fi

if [ -z ${args[2]} ]; then
    echo "Credentials username not set. Exiting..."
    exit 1
fi

if [ -z ${args[3]} ]; then
    echo "Credentials password not set. Exiting..."
    exit 1
fi

if [ -z ${JENKINS_API_TOKEN} ]; then
    echo "JENKINS_API_TOKEN not set. Exiting..."
    exit 1
fi

jenkins_api_token=${JENKINS_API_TOKEN}
jenkins_host=${JENKINS_HOST:="127.0.0.1"}
jenkins_port=${JENKINS_PORT:="9000"}
jenkins_user=${JENKINS_USER:="admin"}

creds_scope=${args[0]}
creds_id=${args[1]}
creds_username=${args[2]}
creds_password=${args[3]}


json_data=$(cat - <<EOJSON
{
  "": "0",
  "credentials": {
    "scope": "${creds_scope}",
    "id": "${creds_id}",
    "username": "${creds_username}",
    "password": "${creds_password}",
    "description": "My credentials",
    "\$class": "com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl"
  }
}
EOJSON
)

curl -s http://${jenkins_user}:${jenkins_api_token}@${jenkins_host}:${jenkins_port}/credentials/store/system/domain/_/createCredentials \
--data-urlencode "json=${json_data}"