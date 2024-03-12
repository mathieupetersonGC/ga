FROM helpsystems/goanywhere-mft:latest

USER root

RUN yum update && yum -y install nettools && yum -y clean all && rm -rf /var/cache
