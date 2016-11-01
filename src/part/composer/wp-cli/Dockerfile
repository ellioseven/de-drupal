# Install WP CLI.
RUN mkdir -p $HOME/opt/wp \
    && cd $HOME/opt/wp \
    && composer require wp-cli/wp-cli \
    && sed -i '1i PATH="$HOME/opt/wp/vendor/bin:$PATH"' $HOME/.bashrc
