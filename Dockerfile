FROM steamcmd/steamcmd AS steambuild
MAINTAINER Ryan Smith <fragsoc@yusu.org>
MAINTAINER Laura Demkowicz-Duffy <fragsoc@yusu.org>

ARG APPID=1110390
ARG UID=999

ENV CONFIG_LOC="/config"
ENV INSTALL_LOC="/unturnedserver"

# Setup directory perms
RUN mkdir -p $INSTALL_LOC && \
    useradd -m -s /bin/false -u $UID unturned && \
    chown unturned:unturned $INSTALL_LOC
USER unturned

# Install the unturned server
RUN HOME=/home/unturned steamcmd \
    +login anonymous \
    +force_install_dir $INSTALL_LOC \
    +app_update $APPID validate \
    +quit && \
    ln -s $CONFIG_LOC $INSTALL_LOC/Servers/Docker

# I/O
VOLUME $CONFIG_LOC
EXPOSE 27015 27015/udp
EXPOSE 27016 27016/udp
EXPOSE 27017 27017/udp

# Expose and run
WORKDIR $INSTALL_LOC
ENTRYPOINT ./ServerHelper.sh -logfile 2>&1 +InternetServer/Docker
