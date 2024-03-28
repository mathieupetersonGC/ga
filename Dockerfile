FROM helpsystems/goanywhere-mft:7.4.2

COPY /lib/* /opt/HelpSystems/GoAnywhere/lib/

USER root

COPY /scripts/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh \
  && chown -R gamft:gamft /etc/HelpSystems \
  && chown -R gamft:gamft /opt/HelpSystems

RUN rm -rf /etc/yum.repos.d/linuxrepos.repo

RUN yum update -y && yum -y install procps && yum -y clean all && rm -rf /var/cache

USER gamft