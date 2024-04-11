FROM helpsystems/goanywhere-mft:latest

ARG VERSION=6.12.0.199

USER root

COPY /scripts/entrypoint.sh /usr/bin/

COPY /configs/* /home/azureuser/volumes/sharedconfig/ 

RUN chmod +x /usr/bin/entrypoint.sh \
  && chown -R gamft:gamft /etc/HelpSystems \
  && chown -R gamft:gamft /opt/HelpSystems

RUN rm -rf /etc/yum.repos.d/linuxrepos.repo

RUN yum update -y && yum -y install procps && yum -y clean all && rm -rf /var/cache
RUN cd /home/azureuser/
RUN curl -o /home/azureuser/mono-6.12.0.199.tar.xz https://download.mono-project.com/sources/mono/mono-$VERSION.tar.xz
RUN tar xvf /home/azureuser/mono-6.12.0.199.tar.xz
RUN cd mono-$VERSION
RUN ./configure --prefix=/usr/local
RUN make
RUN make install

USER gamft