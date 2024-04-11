FROM helpsystems/goanywhere-mft:latest

ARG VERSION=6.12.0.199

COPY /lib/* /opt/HelpSystems/GoAnywhere/lib/

USER root

COPY /scripts/entrypoint.sh /usr/bin/

COPY /configs/* /home/azureuser/volumes/sharedconfig/ 

RUN chmod +x /usr/bin/entrypoint.sh \
  && chown -R gamft:gamft /etc/HelpSystems \
  && chown -R gamft:gamft /opt/HelpSystems

RUN rm -rf /etc/yum.repos.d/linuxrepos.repo

RUN yum update -y \
  && yum -y install procps xz gcc gcc-c++ make perl-ExtUtils-MakeMaker.noarch unzip \
  && yum -y clean all \
  && rm -rf /var/cache
RUN dnf -y install cmake python

# Installing aws cli.
RUN curl -o "awscliv2.zip" "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

# Installing Mono (dependency for marcEdit).
#RUN curl -o /home/azureuser/mono-$VERSION.tar.xz https://download.mono-project.com/sources/mono/mono-$VERSION.tar.xz
#RUN tar xvf /home/azureuser/mono-$VERSION.tar.xz
#WORKDIR mono-$VERSION
#RUN ./configure --prefix=/usr/local
#RUN make
#RUN make install

# Installing marcedit7.
#RUN curl -o /home/azureuser/marcedit.run https://marcedit.reeset.net/software/marcedit7/marcedit7.run
#RUN /home/azureuser/marcedit.run --target /home/azureuser/marcedit

#WORKDIR /

USER gamft