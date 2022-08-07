#!/bin/bash

function main_installation {
  echo "main_installation"
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