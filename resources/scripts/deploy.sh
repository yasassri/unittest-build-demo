#!/bin/bash
set -e

##
# This script takes care of deploying the artiffacts
# @param: $1: environment name
# @param: $2: Service Name
##

########################
##   Main Execution   ##
########################

# Check if the corrent params are passed
if [ -z "$1" ]
    then
        echo "The environment name was not passed"
        exit 1
elif [ -z "$2" ]
    then
        echo "The Service name was not passed"
        exit 1
fi

ENV_NAME="$1"
SERVICE_NAME="$2"
WORKSPACE="/workspace"
NEXUS_URL=$NEXUS_REPO_URL/integrations.zip
echo "Starting the Deploy process in the Environment: $ENV_NAME!!"
source $WORKSPACE/specs/resources/scripts/maas-service.sh

getAccessToken $TEN_ID $AD_CLIENT_ID $AD_CLIENT_SECRET
echo "The function retured AT $ACCESS_TOKEN"

if [ $ENV_NAME == "staging" ]
then
   echo "Calling the Maas API to deploy the service"
   createRelease $SERVICE_NAME $ENV_NAME $NEXUS_URL $ACCESS_TOKEN
   triggerRelease $RELEASE_ID $ACCESS_TOKEN
   echo "Waiting for the deployment to comlete"
elif [ $ENV_NAME == "prod" ]
then
   echo "Calling the Maas Release API to Release the service"
   echo "Waiting for the deployment to comlete"
else
   echo "[ERROR] The provided environment is not known!"
   exit 1
fi
