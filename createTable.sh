#!/bin/bash
clear
while true 
do
echo -e "1- Press 1 to proceed with creating the table\n2- Press 2 to go back to the previous menu"
echo "Please choose one of the option: "
read choice
clear
	case $choice in 
	1) . ./cols.sh
		break
			;;
	2) . ./second.sh
			;;
	*) clear 
		echo "Invalid option"
			;;
	esac
done


