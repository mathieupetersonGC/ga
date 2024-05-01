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
shareconfig_folder="/etc/HelpSystems/GoAnywhere/sharedconfig"
tomcat_folder="/etc/HelpSystems/GoAnywhere/tomcat"
ls -la /tmp
cp /tmp/sharedconfig/*.xml "${shareconfig_folder}"
ls -la /tmp/sharedconfig/
cp -R /tmp/sharedconfig/conf/ "${tomcat_folder}"

# Update ports and db location in different files.
if [ -f "upgrader/ga_upgrade.jar" ]
then
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
  sed -i "s|systemName\">.*<|systemName\">MFT-$host<|g" "${config_folder}"/cluster.xml
  sed -i "s|clusterBindAddress\">.*<|clusterBindAddress\">$host<|g" "${config_folder}"/cluster.xml
  sed -i 's|clusterBindPort">.*<|clusterBindPort">8006<|g' "${config_folder}"/cluster.xml
  sed -i 's|false|true|g' "${config_folder}"/cluster.xml
fi

# Update the file database.xml with the correct values.
sed -i "s|password\">.*<|password\">$DB_PASSWORD<|g" "${shareconfig_folder}"/database.xml
sed -i "s|username\">.*<|username\">$DB_USERNAME<|g" "${shareconfig_folder}"/database.xml
sed -i "s|url\">.*<|url\">$DB_URL<|g" "${shareconfig_folder}"/database.xml

cd "${config_folder}"
shopt -s extglob
rm -- !("cluster.xml")
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

JVM='1024'
if [ -n "$JAVA_MAX_MEMORY" ]; then
  JVM=$JAVA_MAX_MEMORY
fi

JAVA_OPTS="-Xmx"$JVM"m -XX:MaxMetaspaceSize=1024m -Djava.awt.headless=true"
export JAVA_OPTS

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