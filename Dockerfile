FROM steamcmd/steamcmd AS steambuild
MAINTAINER Ryan Smith <fragsoc@yusu.org>
MAINTAINER Laura Demkowicz-Duffy <fragsoc@yusu.org>

ARG APPID=1110390

USER root

# Upgrade the system
RUN apt update
RUN apt upgrade --assume-yes

# Install the unturned server
RUN mkdir -p /unturnedserver
RUN steamcmd \
    +login anonymous \
    +force_install_dir /unturnedserver \
    +app_update $APPID validate \
    +quit

ARG UID=999

ENV CONFIG_LOC="/config"
ENV INSTALL_LOC="/unturnedserver"

# Setup directory structure and permissions
RUN useradd -m -s /bin/false -u $UID unturned
RUN mkdir -p $CONFIG_LOC $INSTALL_LOC
RUN ln -s $CONFIG_LOC $INSTALL_LOC/Servers/Docker
RUN chown -R unturned:unturned $INSTALL_LOC $CONFIG_LOC

# I/O
VOLUME $CONFIG_LOC
EXPOSE 27015 27015/udp
EXPOSE 27016 27016/udp
EXPOSE 27017 27017/udp

# Expose and run
USER unturned
WORKDIR $INSTALL_LOC
ENTRYPOINT ./ServerHelper.sh -logfile 2>&1 +InternetServer/Docker
