#!/bin/sh

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Set default MySQL root password and auth type.
# mysql -u root -e "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;"

# Install PHP extensions with PECL
pecl install memcached imagick

# Install global Composer packages
/usr/local/bin/composer global require laravel/installer laravel/valet tightenco/lambo squizlabs/php_codesniffer wp-coding-standards/wpcs beyondcode/expose statamic/cli laravel/forge-cli

# Install Laravel Valet
$HOME/.composer/vendor/bin/valet install

# link phpcs
$HOME/.composer/vendor/squizlabs/php_codesniffer/bin/phpcs --config-set installed_paths ~/.composer/vendor/wp-coding-standards/wpcs/

# Create a Sites directory
# This is a default directory for macOS user accounts but doesn't comes pre-installed
mkdir $HOME/Sites

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Add custom plugins for use with ZSH.
git clone https://github.com/jasonmccreary/git-trim.git $ZSH_CUSTOM/plugins/git-trim

# Symlink the Mackup config file to the home directory
ln -s $HOME/.dotfiles/.mackup.cfg $HOME/.mackup.cfg

# Sylink the Lambo config to the home dir
ln -s $HOME/.dotfiles/.lambo $HOME/

# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos
