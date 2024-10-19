#!/bin/sh

echo "Setting up your Mac..."

git config --global diff.colorMoved zebra
git config --global pull.rebase true
git config --global rebase.autoStash true

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Install global Composer packages
/usr/local/bin/composer global require squizlabs/php_codesniffer laravel/forge-cli

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

# Install Deno
curl -fsSL https://deno.land/install.sh | sh

# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos
