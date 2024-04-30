#!/bin/bash

set -e

echo "********************************************"
echo "********************************************"
echo "********************************************"
echo "********************************************"
echo ""
echo ""
echo "........CUSTOM ENTRYPOINT........"
echo ""
echo ""
echo "********************************************"
echo "********************************************"
echo "********************************************"
echo "********************************************"

PRGDIR="/opt/HelpSystems/GoAnywhere"

cd "${PRGDIR}"

# variables.
config_folder="/etc/HelpSystems/GoAnywhere/config"


echo "********************************************"
echo Listing mount...
echo "********************************************"
df -h 

echo ""
echo ""
echo ""

echo "********************************************"
echo Listing /home/volumes/sharedconfig/...
echo "********************************************"
ls -la /home/volumes/sharedconfig/

# variables.
shareconfig_folder="/etc/HelpSystems/GoAnywhere/sharedconfig"




echo ""
echo ""
echo ""

echo "********************************************"
echo Listing "${config_folder}"...
echo "********************************************"

ls -la "${config_folder}"


echo "********************************************"
echo cat ${config_folder}/database.xml...
echo "********************************************"
cat ${config_folder}/database.xml

echo "********************************************"
echo mount...
echo "********************************************"
mount