RUN mkdir -p $HOME/opt/drush \
    && cd $HOME/opt/drush \
    && composer require drush/drush \
    && sed -i '1i PATH="$HOME/opt/drush/vendor/bin:$PATH"' $HOME/.bashrc
