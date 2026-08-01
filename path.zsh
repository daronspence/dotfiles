# Load Node global installed binaries
export PATH="$HOME/.node/bin:$PATH"

# Load scripts from dotfiles.
export PATH="$HOME/.dotfiles/bin:$PATH"

# Composer global
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# Use project specific binaries before global ones
export PATH="node_modules/.bin:vendor/bin:$PATH"

export PATH="/usr/local/sbin:$PATH"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export COMPOSER_MEMORY_LIMIT=-1

# Homebrew binaries at the front, but load after everything else.
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
