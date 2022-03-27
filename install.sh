#!/bin/sh

echo "Setting up your Mac..."

# Install xcode command line tools
xcode-select --install

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Required for M1: https://github.com/Homebrew/install/blob/master/install.sh#L1013-L1015
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>$HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# (Re)link dotfiles files
ln -sfn $HOME/.dotfiles/.zshrc $HOME/.zshrc
ln -sfn $HOME/.dotfiles/.vimrc $HOME/.vimrc
ln -sfn $HOME/.dotfiles/.global-gitignore $HOME/.global-gitignore
ln -sfn $HOME/.dotfiles/.gitconfig $HOME/.gitconfig

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file $DOTFILES/Brewfile

# Install GPG keys
gpg --import-options restore --import $HOME/.gnupg/private.gpg
gpg --import-ownertrust $HOME/.gnupg/ownertrust-gpg.txt

# Reveal git secrets
git secret reveal

# Link SSH config
mkdir $HOME/.ssh
[ -e $DOTFILES/ssh_config ] && ln -sfn $HOME/.dotfiles/ssh_config $HOME/.ssh/config

# Set default MySQL root password and auth type
mysql -u root -e "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY 'password'; FLUSH PRIVILEGES;"

# Install PHP extensions with PECL
pecl install imagick redis swoole

# Install global Composer packages
/usr/local/bin/composer global require laravel/installer laravel/valet spatie/global-ray laravel/envoy laravel/vapor-cli

# Install Laravel Valet
$HOME/.composer/vendor/bin/valet install

# Install Global Ray
$HOME/.composer/vendor/bin/global-ray install

# Create a Projects directory
mkdir $HOME/Projects

# Set macOS preferences - we will run this last because this will reload the shell
source $DOTFILES/.macos
