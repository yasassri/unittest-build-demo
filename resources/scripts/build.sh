#!/bin/bash
set -e

##
# This script takes care of build process of the artiffacts
##

WORKSPACE="/workspace"
SOURCE_LOCATION="/workspace/source"
ZIP_NAME="integrations"

# Functions
function echoBold () {
    echo -e $'\e[1m'"${1}"$'\e[0m'
}

########################
##   Main Execution   ##
########################

# Check the welformedness of the maas yaml
echo "Start Execution!!!"
echo $WSO2_SERVER_HOME

# Build with Tests
cd $SOURCE_LOCATION
mvn clean install -DtestServerType=local -DtestServerPath=$WSO2_SERVER_HOME/bin/micro-integrator.sh

# Create the archive
cd $WORKSPACE
createArchive
chmod -R 777 $WORKSPACE
echo "Uploading the Distribution to nexus"
curl -f --show-error -u $NEXUS_USERNAME:$NEXUS_USER_PASSWORD --upload-file $ZIP_NAME.zip  $NEXUS_REPO_URL/$ZIP_NAME.zip
