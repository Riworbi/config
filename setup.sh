#!/bin/bash

# Install fish shell
sudo add-apt-repository ppa:fish-shell/release-4
sudo apt update
sudo apt install fish


# Set fish shell as default

if grep -q "/usr/bin/fish" /etc/shells; then
	echo "Fish default set"
else
	echo /usr/bin/fish | sudo tee -a /etc/shells
	chsh -s /usr/bin/fish
fi


mkdir ~/.config/fish
touch ~/.config/fish/config.fish


# Install starship for fish shell
curl -sS https://starship.rs/install.sh | sh

if grep -q "starship init fish | source" ~/.config/fish/config.fish; then
	echo "Starship set"
else
	echo "starship init fish | source" | sudo tee -a ~/.config/fish/config.fish
fi


# - gruvbox-rainbow theme
starship preset gruvbox-rainbow -o ~/.config/starship.toml

# - vim mode in fish
if grep -q "fish_vi_key_bindings" ~/.config/fish/config.fish; then
	echo "fish Vi mode set"
else
	echo "fish_vi_key_bindings" | sudo tee -a ~/.config/fish/config.fish
fi

# Install nvim
sudo snap install nvim --classic

