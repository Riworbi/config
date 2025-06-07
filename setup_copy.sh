#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
WHITE='\e[0m'

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
		print_color ${RED}  "($1) is not present adding...!"
		echo "$1" | sudo tee -a "$2"
	fi
}

install_package() {
	read -p "Do you want to install $1 [Y/N]? " answer
	case "$answer" in
		[Yy]*)
			echo "Proceeding with installation..."
			;;
		[Nn]*)
			echo "Exiting without installation."
			exit 0
			;;
		*)
			echo "Invalid input. Please enter Y or N."
			install_package  # Prompt again for valid input
			;;
	esac
}


fish_shell(){

	print_color ${GREEN} 'INSTALL fish_shell'
	sudo add-apt-repository ppa:fish-shell/release-4
	sudo apt update
	sudo apt install fish
	print_color ${GREEN}  'SHELL INSTALLED'	
}

check_if_string_exists_in_file() {
	if grep -q "$1" $2; then
		print_color ${GREEN}  "($1) is present !"	
		print_color ${GREEN}  "($1) quitting...  !"	
		exit
	else
		print_color ${RED}  "($1) is not  present !"
	fi
}


# MAIN 

fish_shell
print_color ${GREEN} "Changing shell to fish"
chsh -s /usr/bin/fish

mkdir -p ~/.config/fish
touch ~/.config/fish/config.fish

# Starship:
install_package "starship"
curl -sS https://starship.rs/install.sh | sh
add_to_end_of_file "starship init fish | source" "$FISH_SHELL_CONFIG"
starship preset gruvbox-rainbow -o ~/.config/starship.toml
add_to_end_of_file "fish_vi_key_bindings" $FISH_SHELL_CONFIG


install_package "tmux"
touch ~/.tmux.conf
add_to_end_of_file "set-option -g default-shell /usr/bin/fish" $TMUX_CONFIG

install_package "nvim"
sudo snap install nvim --classic
