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


cd "${config_folder}"
#shopt -s extglob
#rm -- !("cluster.xml")
ln -s "${shareconfig_folder}"/database.xml "${config_folder}"/database.xml
ln -s "${shareconfig_folder}"/agent.xml "${config_folder}"/agent.xml
ln -s "${shareconfig_folder}"/ftp.xml "${config_folder}"/ftp.xml
ln -s "${shareconfig_folder}"/ftps.xml "${config_folder}"/ftps.xml
ln -s "${shareconfig_folder}"/gateway.xml "${config_folder}"/gateway.xml
ln -s "${shareconfig_folder}"/gofast.xml "${config_folder}"/gofast.xml
ln -s "${shareconfig_folder}"/https.xml "${config_folder}"/https.xml
ln -s "${shareconfig_folder}"/log4j2.xml "${config_folder}"/log4j2.xml
ln -s "${shareconfig_folder}"/pesit.xml "${config_folder}"/pesit.xml
ln -s "${shareconfig_folder}"/security.xml "${config_folder}"/security.xml
ln -s "${shareconfig_folder}"/sftp.xml "${config_folder}"/sftp.xml

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