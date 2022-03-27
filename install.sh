#!/bin/sh

export DOTFILES=$HOME/.dotfiles

info() {
    printf "\r\n\e[1;45m $1 \e[0m\n"
}

info "Setting up your Mac..."

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
    info "Installing Oh My Zsh!..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
    info "Installing Homebrew..."

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Required for M1: https://github.com/Homebrew/install/blob/master/install.sh#L1013-L1015
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>$HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

info "(Re-)linking dotfiles..."
ln -sfn $HOME/.dotfiles/.zshrc $HOME/.zshrc
ln -sfn $HOME/.dotfiles/.vimrc $HOME/.vimrc
ln -sfn $HOME/.dotfiles/.global-gitignore $HOME/.global-gitignore
ln -sfn $HOME/.dotfiles/.mackup.cfg $HOME/.mackup.cfg

info "Updating Homebrew recipes..."
brew update

# Install all our dependencies with bundle (See Brewfile)
info "Installing homebrew/bundle..."
brew tap homebrew/bundle
info "Installing Brewfile..."
brew bundle --file $DOTFILES/Brewfile

info "Installing fzf for Oh My Zsh!..."
$(brew --prefix)/opt/fzf/install
info "Installing PHP extensions with PECL..."
pecl install imagick redis swoole

info "Installing global Composer packages..."
/opt/homebrew/bin/composer  global require laravel/installer laravel/valet spatie/global-ray laravel/envoy laravel/vapor-cli

info "Installing Laravel Valet..."
$HOME/.composer/vendor/bin/valet install

info "Installing Global Ray..."
$HOME/.composer/vendor/bin/global-ray install

info "Creating ~/Projects directory..."
mkdir $HOME/Projects

# Set macOS preferences - we will run this last because this will reload the shell
info "Set macOS preferences..."
source $DOTFILES/.macos
