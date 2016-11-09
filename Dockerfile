FROM alpine:edge
MAINTAINER Alan Bondarchuk <imacoda@gmail.com>

# Let's roll
# Install packages
RUN echo 'http://alpine.gliderlabs.com/alpine/edge/main' > /etc/apk/repositories && \
    echo 'http://alpine.gliderlabs.com/alpine/edge/community' >> /etc/apk/repositories && \
    echo 'http://alpine.gliderlabs.com/alpine/edge/testing' >> /etc/apk/repositories && \

    apk add --update \
        libressl \
        ca-certificates \
        openssh-client \
#        rsync \
        git \
        curl \
        unzip \
#        wget \
#        perl \
#        pcre \
#        imap \
#        mariadb-client \
#        supervisor \
#        nodejs \

        # PHP packages
        php7 \
        php7-pcntl \
#        php7-session \
#        php7-xml \
#        php7-ctype \
#        php7-json \
#        php7-posix \
#        php7-curl \
#        php7-dom \
#        php7-pdo \
#        php7-pdo_mysql \
#        php7-sockets \
#        php7-zlib \
#        php7-mcrypt \
#        php7-mysqli \
#        php7-bz2 \
#        php7-phar \
#        php7-openssl \
#        php7-posix \
#        php7-zip \
#        php7-calendar \
#        php7-iconv \
#        php7-soap \
#        php7-pear \
#        php7-mbstring \
#        php7-ldap \
#        php7-bcmath \
        && \

    # Create symlinks for backward compatibility
    ln -sf /usr/bin/php7 /usr/bin/php && \

    # Install composer
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    chmod +x /usr/local/bin/composer && \
    composer global require hirak/prestissimo:^0.3 --optimize-autoloader && \

    # Cleanup
    apk del --purge \
        *-dev \
        build-base \
        autoconf \
        libtool \
        curl \
        openssl \
        && \

    rm -rf \
        /usr/include/php \
        /usr/lib/php/build \
        /var/cache/apk/* \
        /tmp/* \
        /root/.composer

WORKDIR /var/www/html
VOLUME /var/www/html

# Command
CMD ["/usr/local/bin/composer", "--help"]
