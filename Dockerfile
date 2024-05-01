FROM helpsystems/goanywhere-mft:latest

#COPY /lib/* /opt/saxon/lib/

USER root

COPY /scripts/entrypoint.sh /usr/bin/
#COPY /scripts/setenv.sh /opt/HelpSystems/GoAnywhere/tomcat/bin/

COPY /configs/ /tmp/sharedconfig/ 
RUN chmod -R 777 /tmp/sharedconfig/ 

RUN chmod +x /usr/bin/entrypoint.sh

RUN rm -rf /etc/yum.repos.d/linuxrepos.repo

# Installing dependencies.
RUN yum update -y \
  && yum -y install procps unzip epel-release \
  && yum -y clean all \
  && rm -rf /var/cache
#RUN dnf -y install mono-complete

# Installing aws cli.
#RUN curl -o "awscliv2.zip" "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
#RUN unzip awscliv2.zip
#RUN ./aws/install

# Installing marcedit7.
#RUN curl -o /opt/marcedit.run https://marcedit.reeset.net/software/marcedit7/marcedit7.run
#RUN chmod u+x /opt/marcedit.run
#RUN /opt/marcedit.run --target /opt/marcedit
#RUN chmod -R 755 /opt/marcedit

# Cleanup
#RUN rm /opt/marcedit.run \
#  && rm awscliv2.zip

USER gamft