#!/usr/bin/env bash

# Entrypoint for tanzu-runsh-setup-action

# This script expects that the following environment variables have been set:
#
# * TANZU_CLI_ENABLED
# * GOOGLE_PROJECT_ID
# * GOOGLE_SERVICE_ACCOUNT_KEY
#

if [ x"${GOOGLE_PROJECT_ID}" == "x" ] || [ x"${GOOGLE_SERVICE_ACCOUNT_KEY}" == "x" ]; then
  echo "Expected GOOGLE_PROJECT_ID and GOOGLE_SERVICE_ACCOUNT_KEY enviroment variables to have been set!"
  exit 1;
fi

echo "Activating service account and exporting GOOGLE_APPLICATION_CREDENTIALS environment variable."
mkdir -p $HOME/.google
echo "$GOOGLE_SERVICE_ACCOUNT_KEY" | base64 -d > $HOME/.google/credentials.json
chmod 600 $HOME/.google/credentials.json
gcloud auth activate-service-account --project $GOOGLE_PROJECT_ID --key-file=$HOME/.google/credentials.json
export GOOGLE_APPLICATION_CREDENTIALS=$HOME/.google/credentials.json

if [ "${TANZU_CLI_ENABLED}" == "true" ]; then
  mkdir -p /etc/apt/keyrings
  curl -fsSL https://packages.vmware.com/tools/keys/VMWARE-PACKAGING-GPG-RSA-KEY.pub | gpg --dearmor -o /etc/apt/keyrings/tanzu-archive-keyring.gpg
  echo "deb [signed-by=/etc/apt/keyrings/tanzu-archive-keyring.gpg] https://storage.googleapis.com/tanzu-cli-os-packages/apt tanzu-cli-jessie main" | tee /etc/apt/sources.list.d/tanzu.list
  apt update
  apt install tanzu-cli -y
  tanzu config eula accept
  TANZU_CLI_CEIP_OPT_IN_PROMPT_ANSWER="no"
  tanzu plugin group search
  tanzu plugin install --group vmware-tanzucli/essentials
  tanzu plugin install --group vmware-tap/default
  tanzu plugin install --group vmware-tap_saas/app-developer
  tanzu plugin install --group vmware-tap_saas/platform-engineer
  tanzu plugin install --group vmware-tkg/default
  tanzu plugin install --group vmware-tmc/default
  tanzu plugin install --group vmware-vsphere/default
else
  echo "Not installing tanzu CLI nor configuring plugins"
fi

if [ -z "$3" ]; then
  echo "Base64 encoded KUBECONFIG contents not supplied"
else
  echo "Exporting KUBECONFIG environment variable."
  mkdir -p $HOME/.kube
  echo "$3" | base64 -d > $HOME/.kube/config
  chmod 600 $HOME/.kube/config
  export KUBECONFIG=$HOME/.kube/config
fi

echo "Executing script."
echo "$1" | base64 -d > run.sh
chmod +x run.sh
read -r -a args <<< "$2"
. ./run.sh ${args[@]}
