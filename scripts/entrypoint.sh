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
echo "Updating files permissions for /etc/HelpSystems/GoAnywhere and /opt/HelpSystems/GoAnywhere directories..."
sudo find /etc/HelpSystems/GoAnywhere \! -user gamft -exec chown gamft:root {} \;
sudo find /opt/HelpSystems/GoAnywhere \! -user gamft -exec chown gamft:root {} \;

cd /opt/HelpSystems/GoAnywhere

# Update the file: cluster.xml with the host values.
if [ "$MFT_CLUSTER" == "TRUE" ]; then
  host=`hostname -i`
  sed -i "s|systemName\">.*<|systemName\">$SYSTEM_NAME<|g" /etc/HelpSystems/GoAnywhere/config/cluster.xml
  sed -i "s|clusterBindAddress\">.*<|clusterBindAddress\">$host<|g" /etc/HelpSystems/GoAnywhere/config/cluster.xml
  sed -i 's|clusterBindPort"><|clusterBindPort">8006<|g' /etc/HelpSystems/GoAnywhere/config/cluster.xml
  sed -i 's|false|true|g' /etc/HelpSystems/GoAnywhere/config/cluster.xml
fi

# Update the file database.xml with the correct values.
sed -i "s|sequencePoolMaxIdle\">.*<|sequencePoolMaxIdle\">5<|g" /etc/HelpSystems/GoAnywhere/config/database.xml
sed -i "s|password\">.*<|password\">$DB_PASSWORD<|g" /etc/HelpSystems/GoAnywhere/config/database.xml
sed -i "s|username\">.*<|username\">$DB_USERNAME<|g" /etc/HelpSystems/GoAnywhere/config/database.xml
sed -i "s|driverClassName\">.*<|driverClassName\">$DB_DRIVERCLASSNAME<|g" /etc/HelpSystems/GoAnywhere/config/database.xml
sed -i "s|url\">.*<|url\">$DB_URL<|g" /etc/HelpSystems/GoAnywhere/config/database.xml
grep -qxF 'passwordIsEncrypted' /etc/HelpSystems/GoAnywhere/config/database.xml || sed -i "s|</properties>|<entry key=\"passwordIsEncrypted\">true</entry>\r</properties>|g" /etc/HelpSystems/GoAnywhere/config/database.xml

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