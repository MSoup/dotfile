#!/usr/bin/env bash

set -e # fail on error
set -u # error on undefined variables

echo "Starting .dotfiles install"

if ! command -v brew >/dev/null; then
    echo "Installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "Homebrew installed, skipping brew"
fi

brew update --quiet

echo "Installing brew packages"
brew install --quiet --formula \
    colima \
    docker-compose \
    docker-credential-helper \
    git \
    jq \
    lazygit \
    node \
    nvm \
    python@3.12 \
    python@3.13 \
    terraform \
    tree \
    vim \
    zsh
    ;

echo "Installing extras"
brew install --cask --quiet \
    1password \
    discord \
    iterm2 \
    obsidian \
    postman \
    raycast \
    rectangle \
    slack \
    visual-studio-code \
    zoom \
    ;

echo "Installing oh-my-zsh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    echo "oh-my-zsh installed, skipping"
fi

echo "Generating SSH keypair"
if [ ! -f "$HOME/.ssh/id_rsa" ]; then
    ssh-keygen -t rsa -b 4096 -N '' -f "$HOME/.ssh/id_rsa" <<<y >/dev/null 2>&1
    echo "SSH keypair generated"
    echo "Add the following public key to your repositories:"
    cat "$HOME/.ssh/id_rsa.pub"

# Prettify terminal prompt
cp terminal_tools/prettify_prompt_cmd.sh ~/.prettify_prompt_cmd
if ! grep -Fxq "source ~/.prettify_prompt_cmd" ~/.zshrc; then
    echo "source ~/.prettify_prompt_cmd" >> ~/.zshrc
fi
