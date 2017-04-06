USER app

RUN mkdir -p $HOME/.local/opt/drush \
    && cd $HOME/.local/opt/drush \
    && composer require drush/drush \
    && sed -i '1i PATH="$HOME/.local/opt/drush/vendor/bin:$PATH"' $HOME/.bashrc

USER root
