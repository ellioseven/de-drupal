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
