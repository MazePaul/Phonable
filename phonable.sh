#!/bin/bash

List_packages_to_install=("bash" "curl" "gnupg" "snap" "snapd-xdg-open" "bsdutils" "build-essential" "darktable" "findutils" "gh" "gpick" "grep" "htop" "net-tools" "powertop" "resolvconf" "ssh" "steam-installer" "sublime-text" "telegram-desktop" "tlp" "vim" "virt-manager" "wireguard")
#List_packages_to_install_snap=("discord" "bitwarden" "brave" "intellij-idea-community --classic")
List_packages_to_remove=("kdeconnect" "kwalletmanager" "okular" "xterm" "virt-manager" "info" "muon" "skanlite")

function terminal_config {
  echo "Choose Konsole terminal emulator"
  sudo update-alternatives --config x-terminal-emulator
  rm ~/.kde/share/config/kdeglobals
  cp kdeglobals ~/.kde/share/config/kdeglobals
  source ~/.bashrc
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

  for Package_delete in "${List_packages_to_remove[@]}";
        do
          PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $Package_delete | grep "install ok installed")
          echo Checking for $List_packages_to_install: $PKG_OK
          if [ "" = "$PKG_OK" ]; then
            echo "No $Package_delete. Setting up $Package_delete."
            sudo apt-get --yes remove $Package
          fi
        done
  #install_package "$List_packages_to_install_snap" "sudo snap install $Package"
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