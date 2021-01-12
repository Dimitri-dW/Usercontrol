#!/bin/bash

## This script allows you to create a new user, view current users and delte users ##

##### Functions

new_user()						##Create normal user
{
	echo "What is the username?"
	read username
	echo ""
	sudo adduser $username ;sudo passwd $username;
	echo "New user created!"
	echo ""
	read -r -s -p $'Press enter to continue'
	clear
}


new_admin()						##Create a user account with sudo rights
{
	echo "What is the username?"
	read username
	echo ""
	sudo adduser $username ;sudo passwd $username; sudo gpasswd -a $username wheel
	echo "New administartor created!"
	echo ""
	read -r -s -p $'Press enter to continue'
	clear
}

new_guest()						##Create a user account withour sudo rights or password
{
	echo "What is the username?"
	read username
	echo ""
	sudo adduser $username
	echo "new guest created!"
	echo ""
	read -r -s -p $'Press enter to continue'
	clear
	
}

check_user()					##Function to check useraccounts on the server
{
	echo "#####USERS#####"
	echo ""
	cut -d: -f1,3 /etc/passwd |egrep ':[0-9]{4}$'|cut -d: -f1
	echo ""
	read -r -s -p $'Press enter to continue'
	clear
}

change_passwd()					##Function to change the password of the user
{
	echo "#####USERS#####"
	echo ""
	cut -d: -f1,3 /etc/passwd |egrep ':[0-9]{4}$'|cut -d: -f1
	echo ""
	echo "Change password from which user?"
	read username
	sudo passwd $username
	echo "password updated!"
	echo ""
	read -r -s -p $'Press enter to continue'
	clear
}
	

delete_user()					##Delete users, and select if you want to remove or keep their files
{
	echo -e "\e[31m
	###############
	#\e[1mUSER DELETION\e[0m\e[31m#
	###############\e[0m"
	echo ""
	echo "#####USERS#####"
	echo ""
	cut -d: -f1,3 /etc/passwd |egrep ':[0-9]{4}$'|cut -d: -f1
	echo ""
	echo "What user do you want to delete?"
	read username
	echo ""
	read -p "
	User $username selected

	1 Keep Files
	2 Remove Files
	3 Cancel

        Make selection: " files
	
	if [ "$files" = "1" ]
	then 
		sudo userdel $username
		echo ""
		echo "User and files deleted"
		echo ""
		read -r -s -p $'Press enter to continue'
		echo ""
		read -r -s -p $'Press enter to continue'
		clear

	elif [ "$files" = "2" ]
	then 
		sudo userdel -r $username
		echo ""
		echo "User and files deleted"
		echo ""
		read -r -s -p $'Press enter to continue'
		clear

	elif [ "$files" = "3" ]
	then
		echo "cancelled"
		echo ""
		read -r -s -p $'Press enter to continue'
		clear

	else
		read -p "invalid input" -t 2; clear;  delete_user

	fi
       	
}

welcome="\e[1;4;5mWelcome to the user control interface\e[0m"

clear

###Home menu

while true; do 
	read -p $"
###########################################
###$(echo -e "$welcome")###
############_Made by Dimitri-dW_###########



	What do you want to do?

	1 Create new user
	2 Create new administrator
	3 Create new guest (no password)
	4 Check users
	5 Change password
	6 Delete user
	e Exit

Enter the number where you want to navigate: " goto
	case "$goto" in
		[1]) new_user ;;
		[2]) new_admin ;;
		[3]) new_guest ;;
		[4]) check_user ;;
		[5]) change_passwd ;;
		[6]) delete_user ;;
		[e]) read -p "
Closing program" -t 3; clear; exit ;;
		* ) echo "invalid" ;;
	esac
done
