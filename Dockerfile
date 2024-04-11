FROM helpsystems/goanywhere-mft:latest

USER root

COPY /scripts/entrypoint.sh /usr/bin/

COPY /configs/* /home/azureuser/volumes/sharedconfig/ 

RUN chmod +x /usr/bin/entrypoint.sh \
  && chown -R gamft:gamft /etc/HelpSystems \
  && chown -R gamft:gamft /opt/HelpSystems

RUN rm -rf /etc/yum.repos.d/linuxrepos.repo

RUN yum update -y && yum -y install procps && yum -y clean all && rm -rf /var/cache

RUN rpmkeys --import "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF"
RUN su -c 'curl https://download.mono-project.com/repo/centos8-stable.repo | tee /etc/yum.repos.d/mono-centos8-stable.repo'
RUN dnf install mono-devel

USER gamft