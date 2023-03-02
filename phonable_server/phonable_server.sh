#!/bin/bash

function user {
echo "User set up\n"
sudo apt-get update && sudo apt-get upgrade

read -p "Enter user: " user
sudo useradd $user
sudo usermod -aG sudo $user
sudo passwd $user
 
echo "VIM installation + alias"
sudo apt-get install vim
alias="alias vi='vim'"
echo -e "$alias" >> ~/.bashrc
source ~/.bashrc
clear
}

function firewall {
echo "Firewall installation"

sudo apt-get install ufw
sudo ufw allow ssh
sudo ufw enable
clear
}

function ssh {
FILE=~/.ssh/authorized_keys
if [-f "$FILE" ] t; then
	mv sshd_config /etc/ssh/sshd_config
else
	echo "Key missing for ssh connection"
	echo "commands: ssh-keygen -t rsa -b 4096 && ssh-copy-id -i public_key.pub user@ip"
fi
clear
}

function fail2ban {
echo "fail2ban Installation"
sudo apt-get install fail2ban
sudo mv jail.conf /etc/fail2ban/jail.conf
clear
}

user
firewall
fail2ban
ssh
