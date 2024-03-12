FROM helpsystems/goanywhere-mft:latest

USER root

RUN rm -rf /etc/yum.repos.d/linuxrepos.repo

RUN yum update 
RUN yum -y install procps 
RUN yum -y clean all 
RUN rm -rf /var/cache
