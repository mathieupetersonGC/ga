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

RUN yum update -y && yum -y install procps xz gcc gcc-c++ make perl-ExtUtils-MakeMaker.noarch unzip && yum -y clean all && rm -rf /var/cache
RUN dnf -y install cmake python3 python3-devel

# Installing aws cli.
RUN curl -o "awscli-bundle.zip" "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip"
RUN unzip awscli-bundle.zip
RUN ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

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