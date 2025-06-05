#!/bin/bash

# Install fish shell
sudo add-apt-repository ppa:fish-shell/release-4
sudo apt update
sudo apt install fish


# Set fish shell as default
echo /usr/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish


# Install starship for fish shell
curl -sS https://starship.rs/install.sh | sh
echo "starship init fish | source" | sudo tee -a ~/.config/fish/config.fish

# - gruvbox-rainbow theme
starship preset gruvbox-rainbow -o ~/.config/starship.toml

# - vim mode in fish
echo "fish_vi_key_bindings" | sudo tee -a ~/.config/fish/config.fish


# Install nvim
sudo snap install nvim --classic


# Alias
alias --save v_fish='cd ~/.config/fish && vim config.fish'
alias --save vi='nvim .'
