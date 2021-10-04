FROM nextcloud:stable

########################################
#               Build                  #
########################################
ARG VERSION "22.2.0"
ARG DOWNLOADURL "https://download.nextcloud.com/server/releases/nextcloud-22.2.0.tar.bz2"
ARG BUILD "20211004"
########################################

ENV NEXTCLOUD_UPDATE=1

RUN mkdir -p /usr/share/man/man1 \
    && apt-get update && apt-get install -y \
        supervisor \
        ffmpeg \
        libmagickwand-dev \
        libgmp3-dev \
        libc-client-dev \
        libkrb5-dev \
        smbclient \
        libsmbclient-dev \
        inotify-tools \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install bz2 gmp imap \
    && pecl install imagick smbclient \
    && docker-php-ext-enable imagick smbclient 
COPY nextcloud-entrypoint.sh /
COPY supervisord.conf /etc/

ENTRYPOINT ["/nextcloud-entrypoint.sh"]
CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]
