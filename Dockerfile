FROM helpsystems/goanywhere-mft:latest

USER root

COPY /scripts/entrypoint.sh /usr/bin/

COPY /config/* /home/volumes/sharedconfig/ 

RUN chmod +x /usr/bin/entrypoint.sh

RUN rm -rf /etc/yum.repos.d/linuxrepos.repo

# Installing dependencies.
RUN yum update -y \
  && yum -y install procps unzip epel-release \
  && yum -y clean all \
  && rm -rf /var/cache

#USER gamft