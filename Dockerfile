FROM helpsystems/goanywhere-mft:latest

ARG VERSION=6.12.0.199
ENV CLASSPATH="/opt/HelpSystems/GoAnywhere/lib/saxon-he-12.4.jar:/opt/HelpSystems/GoAnywhere/lib/xmlresolver-5.2.2.jar"

COPY /lib/* /opt/HelpSystems/GoAnywhere/lib/

USER root

COPY /scripts/entrypoint.sh /usr/bin/

COPY /configs/* /home/azureuser/volumes/sharedconfig/ 

RUN chmod +x /usr/bin/entrypoint.sh \
  && chown -R gamft:gamft /etc/HelpSystems \
  && chown -R gamft:gamft /opt/HelpSystems

RUN rm -rf /etc/yum.repos.d/linuxrepos.repo

# Installing dependencies.
RUN yum update -y \
  && yum -y install procps unzip epel-release \
  && yum -y clean all \
  && rm -rf /var/cache
RUN dnf -y install mono-complete

# Installing aws cli.
RUN curl -o "awscliv2.zip" "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

# Installing marcedit7.
RUN curl -o /opt/marcedit.run https://marcedit.reeset.net/software/marcedit7/marcedit7.run
RUN chmod u+x /opt/marcedit.run
RUN /opt/marcedit.run --target /opt/marcedit
RUN chmod -R 755 /opt/marcedit

# Cleanup
RUN rm /opt/marcedit.run \
  && rm awscliv2.zip

USER gamft