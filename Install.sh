#!/usr/bin/env bash
#HomeBrew script for installing framework for application to work.
echo "Starting installing Intel-Power-Gadget.framework"

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
echo "Installing homebrew..."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew cask install intel-power-gadget
