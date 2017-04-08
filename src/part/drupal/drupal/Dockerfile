# Drupal.

ADD xdebug.conf /tmp/xdebug.conf
ADD drupal-install.sh /usr/bin/drupal-install.sh
RUN chmod +x /usr/bin/drupal-install.sh \
    && sh /usr/bin/drupal-install.sh \
    && rm /usr/bin/drupal-install.sh \
    && rm /tmp/xdebug.conf

# Expose port 9000 for Xdebug remote.
EXPOSE 9000
