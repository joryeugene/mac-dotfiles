#!/bin/bash

echo "Discovering user-installed Brew packages and casks..."

# List user-installed formulae
brew leaves > user_installed_formulae.txt

# List user-installed casks
brew list --cask > user_installed_casks.txt

echo "Brew discovery complete. Results saved in user_installed_formulae.txt and user_installed_casks.txt"
