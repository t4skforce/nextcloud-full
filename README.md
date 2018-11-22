# nextcloud-full

The `full` Dockerfile adds dependencies for all optional packages suggested by nextcloud that may be needed for some features (e.g. Video Preview Generation), as stated in the [Administration Manual](https://docs.nextcloud.com/server/12/admin_manual/installation/source_installation.html).

NOTE: The Dockerfile does not install the LibreOffice package (line is commented), because it would increase the generated Image size by approximately 500 MB. In order to install it, simply uncomment the 13th line of the Dockerfile.  

NOTE: Per default, only previews for BMP, GIF, JPEG, MarkDown, MP3, PNG, TXT, and XBitmap Files are generated. The configuration of the preview generation can be done in config.php, as explained in the [Administration Manual](https://docs.nextcloud.com/server/12/admin_manual/configuration_server/config_sample_php_parameters.html#previews)  

NOTE: Nextcloud recommends [disabling preview generation](https://docs.nextcloud.com/server/12/admin_manual/configuration_server/harden_server.html?highlight=enabledpreviewproviders#disable-preview-image-generation) for high security deployments, as preview generation opens your nextcloud instance to new possible attack vectors.  

The required steps for each optional/recommended package that is not already in the Nextcloud image are listed here, so that the Dockerfile can easily be modified to only install the needed extra packages. Simply remove the steps for the unwanted packages  from the Dockerfile.

#### PHP Module bz2
`docker-php-ext-install bz2`  

#### PHP Module imagick
`apt install libmagickwand-dev`  
`pecl install imagick`  
`docker-php-ext-enable imagick`  

#### PHP Module imap
`apt install libc-client-dev libkrb5-dev`  
`docker-php-ext-configure imap --with-kerberos --with-imap-ssl`  
`docker-php-ext-install imap`  

#### PHP Module gmp
`apt install libgmp3-dev`  
`docker-php-ext-install gmp`  

#### PHP Module smbclient
`apt install smbclient libsmbclient-dev`  
`pecl install smbclient`  
`docker-php-ext-enable smbclient`  

#### ffmpeg
`apt install ffmpeg`  
