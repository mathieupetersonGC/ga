FROM helpsystems/goanywhere-mft:latest

USER root

RUN rm -rf /etc/yum.repos.d/linuxrepos.repo

RUN yum update -y && yum -y install procps && yum -y clean all && rm -rf /var/cache
