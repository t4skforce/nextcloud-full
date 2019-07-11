FROM nextcloud:stable

########################################
#               Build                  #
########################################
ENV VERSION "16.0.3"
ENV DOWNLOADURL "https://download.nextcloud.com/server/releases/nextcloud-16.0.3.tar.bz2"
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
        youtube-dl \
        aria2 \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && ln -s "/usr/include/$(dpkg-architecture --query DEB_BUILD_MULTIARCH)/gmp.h" /usr/include/gmp.h \
    && docker-php-ext-install bz2 gmp imap \
    && pecl install imagick smbclient \
    && docker-php-ext-enable imagick smbclient \
    && ln -s /usr/bin/youtube-dl /usr/local/bin/youtube-dl
COPY aria2-server.sh nextcloud-cron.sh /usr/bin/
COPY nextcloud-entrypoint.sh /
COPY supervisord.conf /etc/

ENTRYPOINT ["/nextcloud-entrypoint.sh"]
CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]
