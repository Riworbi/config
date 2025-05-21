#!/bin/bash

# Install fish shell
sudo add-apt-repository ppa:fish-shell/release-4
sudo apt update
sudo apt install fish

echo /usr/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish


# Install starship for fish shell
curl -sS https://starship.rs/install.sh | sh
echo "starship init fish | source" | sudo tee -a ~/.config/fish/config.fish
starship preset gruvbox-rainbow -o ~/.config/starship.toml

echo "fish_vi_key_bindings" | sudo tee -a ~/.config/fish/config.fish

sudo snap install nvim --classic

alias --save v_fish='cd ~/.config/fish && vim config.fish'
alias --save vi='nvim .'
