FROM helpsystems/goanywhere-mft:latest

COPY /lib/* /opt/HelpSystems/GoAnywhere/lib/

COPY /scripts/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

USER root

RUN rm -rf /etc/yum.repos.d/linuxrepos.repo

RUN yum update -y && yum -y install procps && yum -y clean all && rm -rf /var/cache

USER gamft