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

# Verify files are owned by gamft:root.
#echo "Updating files permissions for /etc/HelpSystems/GoAnywhere and /opt/HelpSystems/GoAnywhere directories..."
#sudo find /etc/HelpSystems/GoAnywhere \! -user gamft -exec chown gamft:root {} \;
#sudo find /opt/HelpSystems/GoAnywhere \! -user gamft -exec chown gamft:root {} \;

rm "/etc/HelpSystems/GoAnywhere/config/database.xml"
ln -s "/etc/HelpSystems/GoAnywhere/sharedconfig/database.xml" "/etc/HelpSystems/GoAnywhere/config/database.xml" 
ls -la /etc/HelpSystems/GoAnywhere/config/

cd /opt/HelpSystems/GoAnywhere

# variables.
config_folder="/etc/HelpSystems/GoAnywhere/config"

# Update ports and db location in different files.
if [ -f "upgrader/ga_upgrade.jar" ]
then
  echo "Updating default port settings for https, ftp, ftps and SFTP..."
  sed -i 's|"443"|"8443"|g' "${config_folder}"/https.xml
  sed -i 's|"21"|"8021"|g' "${config_folder}"/ftp.xml
  sed -i 's|"990"|"8990"|g' "${config_folder}"/ftps.xml
  sed -i 's|"22"|"8022"|g' "${config_folder}"/sftp.xml
  echo "Updating default database location..."
  sed -i 's|/usr/local/HelpSystems/GoAnywhere|/opt/HelpSystems/GoAnywhere|g' "${config_folder}"/database.xml
  echo Running upgrader...
  java -classpath upgrader/ga_upgrade.jar -javaagent:upgrader/ga_upgrade.jar com.linoma.goanywhere.upgrader.Startup skipFiles
  if [ $? -eq 0 ]
  then
    mv upgrader/ga_upgrade.jar upgrader/ga_upgrade_complete.jar
  fi
  else
  echo No upgrade file found, skipping upgrade command
fi

# Update the file: cluster.xml with the host values.
if [ "$MFT_CLUSTER" == "TRUE" ]; then
  host=`hostname -i`
  sed -i "s|systemName\">.*<|systemName\">$SYSTEM_NAME<|g" "${config_folder}"/cluster.xml
  sed -i "s|clusterBindAddress\">.*<|clusterBindAddress\">$host<|g" "${config_folder}"/cluster.xml
  sed -i 's|clusterBindPort"><|clusterBindPort">8006<|g' "${config_folder}"/cluster.xml
  sed -i 's|false|true|g' "${config_folder}"/cluster.xml
fi

# Update the file database.xml with the correct values.
sed -i "s|sequencePoolMaxIdle\">.*<|sequencePoolMaxIdle\">5<|g" "${config_folder}"/database.xml
sed -i "s|password\">.*<|password\">$DB_PASSWORD<|g" "${config_folder}"/database.xml
sed -i "s|username\">.*<|username\">$DB_USERNAME<|g" "${config_folder}"/database.xml
sed -i "s|driverClassName\">.*<|driverClassName\">$DB_DRIVERCLASSNAME<|g" "${config_folder}"/database.xml
sed -i "s|url\">.*<|url\">$DB_URL<|g" "${config_folder}"/database.xml
grep -q 'passwordIsEncrypted' "${config_folder}"/database.xml || sed -i "s|</properties>|<entry key=\"passwordIsEncrypted\">true</entry>\n</properties>|g" "${config_folder}"/database.xml

JVM='1024'
if [ -n "$JAVA_MAX_MEMORY" ]; then
  JVM=$JAVA_MAX_MEMORY
fi

JAVA_OPTS="-Xmx"$JVM"m -XX:MaxMetaspaceSize=1024m -Djava.awt.headless=true"
export JAVA_OPTS

PRGDIR=`pwd`

# Use the bundled JRE if one has been bundled.
if [ -d "$PRGDIR/jre6" ]
then
  export JAVA_HOME="$PRGDIR/jre6"
elif [ -d "$PRGDIR/jre" ]
then
  export JAVA_HOME="$PRGDIR/jre"
fi

EXECUTABLE=tomcat/bin/goanywhere_catalina.sh

exec "$PRGDIR"/"$EXECUTABLE" run "$@"