USER app

RUN . $HOME/.bashrc \
    && mkdir -p $HOME/.local/opt/drupal \
    && cd $HOME/.local/opt/drupal \
    && composer require drupal/console \
    && sed -i '1i PATH="$HOME/.local/opt/drupal/vendor/bin:$PATH"' $HOME/.bashrc

USER root
