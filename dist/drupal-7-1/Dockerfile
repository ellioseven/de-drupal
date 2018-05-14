FROM php:7.1-fpm
MAINTAINER elliot.mitchum@ellioseven.com.au

ENV DRUPAL_DEPS_BUILD \
	libjpeg62-turbo-dev \
	libpng12-dev \
	libpq-dev

ENV DRUPAL_DEPS_RUN \
	bzip2 \
	ca-certificates \
	git \
	libjpeg62-turbo \
	libpq5 \
	mysql-client \
	openssh-client \
	rsync \
	sqlite3 \
	ssmtp \
	wget \
	zip

# Create 'app' user.
RUN groupadd --gid 1000 app \
	&& useradd --uid 1000 --gid app --shell /bin/bash --create-home app \
	&& mkdir -p /home/app/bin \
	&& mkdir -p /home/app/.local/bin \
	&& mkdir -p /home/app/.local/opt \
	&& mkdir -p /home/app/src/docroot \
	&& chown -R app:app /home/app

# Switch PHP-FPM user to 'app'.
RUN sed -i 's/www-data/app/g' /usr/local/etc/php-fpm.d/www.conf

# Create default web root.
RUN mkdir -p /home/app/src/docroot \
    && echo '<?php phpinfo();' >> /home/app/src/docroot/index.php

# Configure ssmtp.
ADD ssmtp.conf /etc/ssmtp/ssmtp.conf
RUN chmod 644 /etc/ssmtp/ssmtp.conf

RUN mkdir -p /home/app/.ssh \
	&& touch /home/app/.ssh/known_hosts \
	&& chown -R app:app /home/app/.ssh

WORKDIR /home/app/src/docroot

ENV PATH /home/app/bin:$PATH
ENV PATH /home/app/.local/bin:$PATH
ENV PATH /home/app/src/vendor/bin:$PATH
ENV PATH /home/app/src/docroot/vendor/bin:$PATH
ENV PATH /home/app/.composer/vendor/bin:$PATH
# Build PHP dependencies.
RUN set -ex \
	# Add build dependencies. \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		$DRUPAL_DEPS_RUN \
		$DRUPAL_DEPS_BUILD \
	&& rm -rf /var/lib/apt/lists/* \
	# Configure 'gd' PHP extension. \
	&& docker-php-ext-configure gd \
		--with-jpeg-dir=/usr \
		--with-png-dir=/usr \
	# Build PHP extensions. \
	&& docker-php-ext-install -j "$(nproc)" \
		gd \
		mbstring \
		opcache \
		pdo \
		pdo_mysql \
		zip \
	# Remove build depdendencies. \
	&& apt-get purge -y --auto-remove $DRUPAL_DEPS_BUILD

# Get PHP development configuration.
ADD https://raw.githubusercontent.com/php/php-src/PHP-$PHP_VERSION/php.ini-development /usr/local/etc/php/php.ini
RUN echo "sendmail_path = /usr/sbin/sendmail -t -i" >> /usr/local/etc/php/php.ini
RUN chmod 755 /usr/local/etc/php/php.ini
# Set recommended opcache.ini settings.
# See https://secure.php.net/manual/en/opcache.installation.php.
COPY opcache-recommended.ini /usr/local/etc/php/conf.d/opcache-recommended.ini
# Install Xdebug extension.
COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
RUN apt-get update \
	&& apt-get install -y --no-install-recommends $PHPIZE_DEPS \
	&& rm -rf /var/lib/apt/lists/* \
	&& pecl channel-update pecl.php.net \
	&& pecl install xdebug \
	&& apt-get purge -y --auto-remove $PHPIZE_DEPS
# Install composer to 'app' user.
# .composer.tmp will be merged to .composer on entrypoint.
USER app
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
	&& php composer-setup.php --filename=composer --install-dir=/home/app/bin \
	&& php -r "unlink('composer-setup.php');" \
	&& composer global require hirak/prestissimo \
	&& mv /home/app/.composer /home/app/.composer.tmp
USER root
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
USER app
CMD ["php-fpm"]
