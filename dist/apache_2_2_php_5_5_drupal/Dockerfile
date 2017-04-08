FROM ellioseven/de_php:apache_2_2_php_5_5

# Drupal.

ADD drupal-install.sh /usr/bin/drupal-install.sh
RUN chmod +x /usr/bin/drupal-install.sh \
    && sh /usr/bin/drupal-install.sh \
    && rm /usr/bin/drupal-install.sh

# Expose port 9000 for Xdebug remote.
EXPOSE 9000

USER app

# @todo Experiment with --install-dir flag.
RUN cd $HOME \
  && wget -q https://getcomposer.org/installer -O installer.php \
  && php installer.php \
  && chmod +x composer.phar \
  && mv composer.phar $HOME/bin/composer \
  && sed -i '1i PATH="$HOME/.composer/vendor/bin:$PATH"' $HOME/.bashrc \
  && rm installer.php \
  && . $HOME/.bashrc

USER root

USER app

RUN . $HOME/.bashrc \
    && mkdir -p $HOME/.local/opt/drush \
    && cd $HOME/.local/opt/drush \
    && composer require drush/drush \
    && sed -i '1i PATH="$HOME/.local/opt/drush/vendor/bin:$PATH"' $HOME/.bashrc

USER root

USER app

RUN . $HOME/.bashrc \
    && mkdir -p $HOME/.local/opt/drupal \
    && cd $HOME/.local/opt/drupal \
    && composer require drupal/console \
    && sed -i '1i PATH="$HOME/.local/opt/drupal/vendor/bin:$PATH"' $HOME/.bashrc

USER root

