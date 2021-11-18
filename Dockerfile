FROM nextcloud:stable

########################################
#               Build                  #
########################################
ARG VERSION "22.2.3"
ARG DOWNLOADURL "https://github.com/nextcloud/docker"
ARG BUILD_DATE="2021-11-18T23:16:12Z"
########################################

# Basic build-time metadata as defined at http://label-schema.org
LABEL org.label-schema.schema-version="1.0" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.license="AGPL-3.0 License" \
    org.label-schema.name="nextcloud-full" \
    org.label-schema.vendor="t4skforce" \
    org.label-schema.version="Nextcloud v${NEXTCLOUD_VERSION}" \
    org.label-schema.description="A safe home for all your data. Access & share your files, calendars, contacts, mail & more from any device, on your terms." \
    org.label-schema.url="https://github.com/t4skforce/nextcloud-full" \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-url="https://github.com/t4skforce/nextcloud-full.git" \
    maintainer="t4skforce" \
    Author="t4skforce"


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
