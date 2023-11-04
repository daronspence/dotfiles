# Load Node global installed binaries
export PATH="$HOME/.node/bin:$PATH"

# Load scripts from dotfiles.
export PATH="$HOME/.dotfiles/bin:$PATH"

# Use project specific binaries before global ones
export PATH="node_modules/.bin:vendor/bin:$PATH"

export PATH="/usr/local/sbin:$PATH"
# Load Composer tools after braodway
export PATH="$HOME/.composer/vendor/bin:$PATH"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export COMPOSER_MEMORY_LIMIT=-1