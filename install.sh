#!/usr/bin/env bash

set -e # fail on error
set -u # error on undefined variables

echo "Starting .dotfiles install"

if ! command -v brew >/dev/null; then
    echo "Installing homebrew"
    # from: https://brew.sh
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "Homebrew installed, skipping brew"
fi

# update homebrew
brew update --quiet
# a sorted list of packages to install
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
    ;

brew install --cask --quiet \
    # 1password \
    # discord \
    iterm2 \
    obsidian \
    postman \
    raycast \
    rectangle \
    slack \
    visual-studio-code \
    zoom \
    ;