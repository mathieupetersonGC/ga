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

echo "********************************************"
echo mount...
echo "********************************************"
mount

echo "********************************************"
echo Listing /home/volumes/sharedconfig/...
echo "********************************************"
ls -la /home/volumes/sharedconfig/



echo ""
echo ""
echo ""

echo "********************************************"
echo Listing "/etc/HelpSystems/GoAnywhere/config"...
echo "********************************************"

ls -la /etc/HelpSystems/GoAnywhere/config/

echo "********************************************"
echo Listing "/opt/HelpSystems/GoAnywhere/"...
echo "********************************************"

ls -la /opt/HelpSystems/GoAnywhere/

echo "********************************************"
echo Listing "/etc/HelpSystems/GoAnywhere/tomcat/"...
echo "********************************************"

ls -la /etc/HelpSystems/GoAnywhere/tomcat/

echo "********************************************"
echo Listing "/etc/HelpSystems/GoAnywhere/sharedconfig/"...
echo "********************************************"

ls -la /etc/HelpSystems/GoAnywhere/sharedconfig/

