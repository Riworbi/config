#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
WHITE='\e[0m'
PURPLE='\033[0;35m'

FISH_SHELL='/usr/bin/fish'
FISH_SHELL_CONFIG='/home/user/.config/fish/config.fish'
TMUX_CONFIG='/home/user/.tmux.conf'

print_color(){
	echo -e "${1}${2}${WHITE}"
}

add_to_end_of_file(){
	if grep -q "$1" "$2"; then
		print_color ${GREEN} "'$1' is present !"	
	else
		print_color ${RED}  "$1 is not present adding...!"
		echo "$1" | sudo tee -a "$2"
	fi
}

fish_shell(){

	print_color ${GREEN} 'Installing fish_shell...'
	sudo add-apt-repository ppa:fish-shell/release-4
	sudo apt update
	sudo apt install fish
	print_color ${GREEN}  'Fish shell Installed'	
}

check_if_string_exists_in_file() {
	if grep -q "$1" $2; then
		print_color ${GREEN}  "$1 is present !"	
		print_color ${GREEN}  "$1 quitting...  !"	
		exit
	else
		print_color ${RED}  "$1 is not  present !"
	fi
}


# ------------ MAIN ------------

# Fish
fish_shell
print_color ${PURPLE} "Changing shell to fish"
chsh -s /usr/bin/fish

# config.fish
print_color ${PURPLE} "Creating config.fish"
mkdir -p ~/.config/fish
touch ~/.config/fish/config.fish

# Starship:
print_color ${PURPLE} "Installing starship..."
curl -sS https://starship.rs/install.sh | sh
add_to_end_of_file "starship init fish | source" "$FISH_SHELL_CONFIG"
starship preset gruvbox-rainbow -o ~/.config/starship.toml
add_to_end_of_file "fish_vi_key_bindings" $FISH_SHELL_CONFIG
print_color ${PURPLE} "starship installed!"

# tmux
print_color ${PURPLE} "Configuring tmux..."
touch ~/.tmux.conf
add_to_end_of_file "set-option -g default-shell /usr/bin/fish" $TMUX_CONFIG

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

add_to_end_of_file "set -g @plugin 'tmux-plugins/tpm'" $TMUX_CONFIG
add_to_end_of_file "set -g @plugin 'tmux-plugins/tmux-sensible'" $TMUX_CONFIG
add_to_end_of_file "set -g @plugin 'egel/tmux-gruvbox'" $TMUX_CONFIG
add_to_end_of_file "set -g @tmux-gruvbox 'dark' # or 'dark256', 'light', 'light256'" $TMUX_CONFIG
add_to_end_of_file "run '~/.tmux/plugins/tpm/tpm'" $TMUX_CONFIG
tmux source ~/.tmux.conf
print_color ${PURPLE} " tmux configured!"

# nvim
print_color ${PURPLE} "Installing nvim..."
install_package "nvim"
sudo snap install nvim --classic
print_color ${PURPLE} "nvim installed!"
