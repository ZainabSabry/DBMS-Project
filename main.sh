#!/bin/bash
clear
shopt -s extglob
export LC_COLLATE=C
PS3="Please choose one of the options: "
echo "========================================="
echo "Welcome to ZaSar, our DBMS!"
echo "Created by Zainab Sabry and Sara Galal"
echo "========================================="


select option in "Create Database" "Connect to Database" "Drop Database" "Show Databases" "Exit"
do
	case $REPLY in
		1) . ./createdb.sh
			;;
		2) . ./connectdb.sh
			;;
		3) . ./dropdb.sh
			;;
		4) . ./showdb.sh
			;;
		5) exit	
			;;	

		*)	echo -e "\nInvalid Option! Please choose again"
			;;
	esac
done
