docker run --name myga --detach \
--publish 9000:8000 \
--publish 9001:8001 \
--publish 9005:8005 \
--publish 9006:8006 \
--publish 9009:8009 \
--publish 9010:8010 \
--publish 9443:8443 \
--publish 9021:8021 \
--publish 9022:8022 \
--publish 32001-32300:32001-32300 \
--volume /home/azureuser/volumes/gamft.lic:/opt/HelpSystems/GoAnywhere/gamft.lic \
--volume userdatadir:/opt/HelpSystems/GoAnywhere/userdata/ \
--volume ${HOME}/volumes/:/opt/HelpSystems/GoAnywhere/upgrader/ \
--volume configdir:/etc/HelpSystems/GoAnywhere/config/ \
--volume tomcatserver:/etc/HelpSystems/GoAnywhere/tomcat/ \
--volume ${HOME}/volumes/:/opt/HelpSystems/GoAnywhere/tomcat/logs/ \
--volume ${HOME}/volumes/:/opt/HelpSystems/GoAnywhere/ghttpsroot/custom/ \
--mac-address "02:42:c0:a8:80:80" \
myga:latest