# Load Node global installed binaries
export PATH="$HOME/.node/bin:$PATH"

# Load scripts from dotfiles.
export PATH="$HOME/.dotfiles/bin:$PATH"

# Composer global
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# Use project specific binaries before global ones
export PATH="node_modules/.bin:vendor/bin:$PATH"

export COMPOSER_MEMORY_LIMIT=-1

# Homebrew binaries at the front, but load after everything else.
case "$(uname -m)" in
    arm64) export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH" ;;
    *) export PATH="/usr/local/bin:/usr/local/sbin:$PATH" ;;
esac
