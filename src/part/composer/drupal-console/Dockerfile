RUN mkdir -p $HOME/opt/drupal \
    && cd $HOME/opt/drupal \
    && composer require drupal/console \
    && sed -i '1i PATH="$HOME/opt/drupal/vendor/bin:$PATH"' $HOME/.bashrc
