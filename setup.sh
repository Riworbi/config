#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'


# Fish shell
sudo add-apt-repository ppa:fish-shell/release-4
sudo apt update
sudo apt install fish

## set  as default

if grep -q "/usr/bin/fish" /etc/shells; then
	echo -e  "${RED} /usr/bin/fish is present changing shell: "
	chsh -s /usr/bin/fish
else
	echo /usr/bin/fish | sudo tee -a /etc/shells
	chsh -s /usr/bin/fish
fi


mkdir ~/.config/fish
touch ~/.config/fish/config.fish

## Starship for fish shell
curl -sS https://starship.rs/install.sh | sh

if grep -q "starship init fish | source" ~/.config/fish/config.fish; then
	echo "Starship set"
else
	echo "starship init fish | source" | sudo tee -a ~/.config/fish/config.fish
fi


## Gruvbox-rainbow theme
starship preset gruvbox-rainbow -o ~/.config/starship.toml

## Vim mode in fish
if grep -q "fish_vi_key_bindings" ~/.config/fish/config.fish; then
	echo "fish Vi mode set"
else
	echo "fish_vi_key_bindings" | sudo tee -a ~/.config/fish/config.fish
fi

# Nvim
sudo snap install nvim --classic

# Tmux
if grep -q "set-option -g default-shell /usr/bin/fish" ~/.tmux.conf; then

	echo "Fish shell set as default for Tmux"
else
	echo "set-option -g default-shell /usr/bin/fish" > ~/.tmux.conf
fi 
