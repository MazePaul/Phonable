#!/bin/bash

List_packages_to_install=("bash" "curl" "gnupg" "snap" "snapd-xdg-open" "bsdutils" "build-essential" "darktable" "findutils" "gh" "gpick" "grep" "htop" "net-tools" "powertop" "resolvconf" "ssh" "steam-installer" "sublime-text" "telegram-desktop" "tlp" "vim" "virt-manager" "wireguard")
List_packages_to_install_snap=("discord" "bitwarden" "brave" "intellij-idea-community --classic")

function install_package {
  for Package in ${$1[@]};
    do
      PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $Package | grep "install ok installed")
      echo Checking for $1[@]: $PKG_OK
      if [ "" = "$PKG_OK" ]; then
        echo "No $Package. Setting up $Package."
        $2 $Package
      fi
    done
}

function terminal_config {
  echo "Choose Konsole terminal emulator"
  sudo update-alternatives --config x-terminal-emulator
  rm ~/.kde/share/config/kdeglobals
  cp kdeglobals ~/.kde/share/config/kdeglobals
  source ~/.bashrc
}

function main_installation {
  install_package $"List_packages_to_install" $"sudo apt-get --yes install $Package"
  install_package $"List_packages_to_install_snap" $"sudo snap install $Package"
  sudo apt-get -f install

  terminal_config
}

function vm_pentest {
  echo "vm_pentest"
}

function server {
  echo "server"
}

PS3='Please enter your choice: '
user_choice=("Main installation" "VM for pentesting" "Server" "Quit")
select input in "${user_choice[@]}"
do
    case $input in
        "Main installation")
            echo "you chose choice 1"
            main_installation
            ;;
        "VM for pentesting")
            echo "you chose choice 2"
            vm_pentest
            ;;
        "Server")
            echo "you chose choice $REPLY which is $opt"
            server
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done