docker run --name ga --detach \
--publish 8000:8000 \
--publish 8001:8001 \
--publish 8005:8005 \
--publish 8006:8006 \
--publish 8009:8009 \
--publish 8010:8010 \
--publish 8443:8443 \
--publish 8021:8021 \
--publish 8022:8022 \
--publish 32001-32300:32001-32300 \
--volume /home/ec2-user/efs/userdatadir:/opt/HelpSystems/GoAnywhere/userdata/ \
--volume /home/ec2-user/efs/upgrader:/opt/HelpSystems/GoAnywhere/upgrader/ \
--volume /home/ec2-user/efs/configdir:/etc/HelpSystems/GoAnywhere/config/ \
--volume /home/ec2-user/efs/tomcatserver:/etc/HelpSystems/GoAnywhere/tomcat/ \
--volume /home/ec2-user/efs/tomcat:/opt/HelpSystems/GoAnywhere/tomcat/logs/ \
--volume /home/ec2-user/efs/ghttpsroot:/opt/HelpSystems/GoAnywhere/ghttpsroot/custom/ \
--volume /home/ec2-user/efs/sharedconfig:/etc/HelpSystems/GoAnywhere/sharedconfig/ \
helpsystems/goanywhere-mft:latest
