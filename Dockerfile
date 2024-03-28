FROM helpsystems/goanywhere-mft:latest

COPY /lib/* /opt/HelpSystems/GoAnywhere/lib/

USER root

COPY /scripts/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh \
  && chown -R gamft:root /etc/HelpSystems/GoAnywhere \
  && chown -R gamft:root /opt/HelpSystems/GoAnywhere

RUN rm -rf /etc/yum.repos.d/linuxrepos.repo

RUN yum update -y && yum -y install procps && yum -y clean all && rm -rf /var/cache

USER gamft