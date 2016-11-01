FROM ellioseven/de_php:apache_2_2_php_5_6

# Drupal.

ADD drupal-install.sh /usr/bin/drupal-install.sh
RUN chmod +x /usr/bin/drupal-install.sh \
    && sh /usr/bin/drupal-install.sh \
    && rm /usr/bin/drupal-install.sh

RUN wget -q https://getcomposer.org/installer -O installer.php \
  && php installer.php \
  && chmod +x composer.phar \
  && mv composer.phar /usr/local/bin/composer \
  && sed -i '1i PATH="$HOME/.composer/vendor/bin:$PATH"' $HOME/.bashrc \
  && rm installer.php

RUN mkdir -p $HOME/opt/drush \
    && cd $HOME/opt/drush \
    && composer require drush/drush \
    && sed -i '1i PATH="$HOME/opt/drush/vendor/bin:$PATH"' $HOME/.bashrc

RUN mkdir -p $HOME/opt/drupal \
    && cd $HOME/opt/drupal \
    && composer require drupal/console \
    && sed -i '1i PATH="$HOME/opt/drupal/vendor/bin:$PATH"' $HOME/.bashrc

