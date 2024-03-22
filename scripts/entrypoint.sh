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

# Verify files are owned by gamft:root
echo "Updating files permissions for /etc/HelpSystems/GoAnywhere and /opt/HelpSystems/GoAnywhere directories..."
sudo find /etc/HelpSystems/GoAnywhere \! -user gamft -exec chown gamft:root {} \;
sudo find /opt/HelpSystems/GoAnywhere \! -user gamft -exec chown gamft:root {} \;

cd /opt/HelpSystems/GoAnywhere

if [ "$MFT_CLUSTER" == "TRUE" ]; then
  host=`hostname -i`
  sed -i "s|systemName\">.*<|systemName\">$SYSTEM_NAME<|g" /etc/HelpSystems/GoAnywhere/config/cluster.xml
  sed -i "s|clusterBindAddress\">.*<|clusterBindAddress\">$host<|g" /etc/HelpSystems/GoAnywhere/config/cluster.xml
  sed -i 's|clusterBindPort"><|clusterBindPort">8006<|g' /etc/HelpSystems/GoAnywhere/config/cluster.xml
  sed -i 's|false|true|g' /etc/HelpSystems/GoAnywhere/config/cluster.xml
fi

JVM='1024'
if [ -n "$JAVA_MAX_MEMORY" ]; then
  JVM=$JAVA_MAX_MEMORY
fi

JAVA_OPTS="-Xmx"$JVM"m -XX:MaxMetaspaceSize=1024m -Djava.awt.headless=true"
export JAVA_OPTS

PRGDIR=`pwd`

# Use the bundled JRE if one has been bundled
if [ -d "$PRGDIR/jre6" ]
then
  export JAVA_HOME="$PRGDIR/jre6"
elif [ -d "$PRGDIR/jre" ]
then
  export JAVA_HOME="$PRGDIR/jre"
fi

EXECUTABLE=tomcat/bin/goanywhere_catalina.sh

exec "$PRGDIR"/"$EXECUTABLE" run "$@"