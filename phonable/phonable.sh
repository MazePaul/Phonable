#!/bin/bash

List_packages_to_install=("bash" "curl" "gnupg" "snap" "snapd-xdg-open" "bsdutils" "build-essential" "darktable" "findutils" "gh" "gpick" "grep" "htop" "net-tools" "powertop" "resolvconf" "ssh" "steam-installer" "sublime-text" "telegram-desktop" "tlp" "vim" "virt-manager" "wireguard")
#List_packages_to_install_snap=("discord" "bitwarden" "brave" "intellij-idea-community --classic")
List_packages_to_remove=("kdeconnect" "kwalletmanager" "okular" "xterm" "virt-manager" "info" "muon" "skanlite")

function terminal_config {
  echo "Choose Konsole terminal emulator"
  sudo update-alternatives --config x-terminal-emulator

  bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"

  #écriture des alias
  cp term_config/bash_config ~/.bashrc
  source ~/.bashrc

  mv term_config/Kali.profile ~/.local/share/konsole/
  mv term_config/Retro_maze.colorscheme ~/.local/share/konsole/
}

function main_installation {
  for Package in "${List_packages_to_install[@]}";
      do
        PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $Package | grep "install ok installed")
        echo Checking for $List_packages_to_install: $PKG_OK
        if [ "" = "$PKG_OK" ]; then
          echo "No $Package. Setting up $Package."
          sudo apt-get --yes install $Package
        fi
      done
  sudo apt-get -f install

  for Package_delete in "${List_packages_to_remove[@]}";
        do
          PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $Package_delete | grep "install ok installed")
          echo Checking for $List_packages_to_remove: $PKG_OK
          if [ "install ok installed" = "$PKG_OK" ]; then
            echo "$Package_delete installed. Deletion of $Package_delete."
            sudo apt-get --yes remove $Package_delete
          fi
        done
  apt autoremove
  #install_package "$List_packages_to_install_snap" "sudo snap install $Package"
  terminal_config
  theme_config
}

function theme_config {
  sudo add-apt-repository ppa:papirus/papirus
  sudo apt update
  sudo apt install qt5-style-kvantum qt5-style-kvantum-themes
  
  sudo apt-get install latte-dock
  cp maze.layout.latte ~/.config/latte/

  #cp Layan ~/.config/Kvantum
  #cp kvantum.kvconfig ~/.config/Kvantum
}

PS3='Please enter your choice: '
user_choice=("Full installation" "Terminal installation" "Theme installation" "Quit")
select input in "${user_choice[@]}"
do
    case $input in
        "Full installation")
            main_installation
            ;;
        "Terminal installation")
            terminal_config
            ;;
        "Theme installation")
            theme_config
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done