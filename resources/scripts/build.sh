#!/bin/bash
set -e

##
# This script takes care of build process of the artiffacts
##

WORKSPACE="/workspace"
SOURCE_LOCATION="/workspace//WSO2API_Test_Demo"

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
