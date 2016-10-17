FROM ellioseven/de_php:apache_2_4_php_5_3

ENV DRUPAL_BUILD_DEPS \
    autoconf \
    g++ \
    gcc \
    file \
    re2c \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libmysqlclient-dev

RUN apt-get update \
    && apt-get -y install $DRUPAL_BUILD_DEPS --no-install-recommends

RUN wget https://secure.php.net/get/php-${PHP_VERSION}.tar.gz/from/this/mirror -O php-${PHP_VERSION}.tar.gz \
    && tar -xvzf php-${PHP_VERSION}.tar.gz

# FIX: configure: error: freetype.h not found.
RUN mkdir /usr/include/freetype2/freetype \
    && ln -s /usr/include/freetype2/freetype.h /usr/include/freetype2/freetype/freetype.h

RUN cd php-${PHP_VERSION}/ext/gd \
    && phpize \
    && ./configure \
    --with-jpeg-dir \
    --with-png-dir \
    --with-freetype-dir \
    --enable-gd-native-ttf \
    && make \
    && make install \
    && echo "extension=gd.so" >> /usr/local/lib/php.ini

RUN cd php-${PHP_VERSION}/ext/mysql \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && echo "extension=mysql.so" >> /usr/local/lib/php.ini

RUN cd php-${PHP_VERSION}/ext/pdo_mysql \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && echo "extension=pdo_mysql.so" >> /usr/local/lib/php.ini

RUN cd php-${PHP_VERSION}/ext/zip \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && echo "extension=zip.so" >> /usr/local/lib/php.ini

# Install Drush.
RUN mkdir -p $HOME/opt/drush \
    && cd $HOME/opt/drush \
    && composer require drush/drush \
    && sed -i '1i PATH="$HOME/opt/drush/vendor/bin:$PATH"' $HOME/.bashrc

CMD ["/usr/local/apache2/bin/apachectl", "-D", "FOREGROUND"]
