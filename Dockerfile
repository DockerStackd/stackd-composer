FROM matriphe/alpine-php:cli
MAINTAINER Alan Bondarchuk <imacoda@gmail.com>

# Let's roll
RUN	apk update && \
	apk upgrade && \
	apk add --update curl openssl && \
	curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
	chmod +x /usr/local/bin/composer && \
	composer global require hirak/prestissimo:^0.3 --optimize-autoloader && \
	apk del curl openssl && \
  rm -rf \
      /usr/include/php \
      /usr/lib/php/build \
      /var/cache/apk/* \
      /tmp/* \
      /root/.composer

# Command
CMD ["/usr/local/bin/composer", "--help"]
