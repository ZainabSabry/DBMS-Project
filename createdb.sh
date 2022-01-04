#!/bin/bash
clear
typeset -i flag
flag=0
while true #"Press 1 to enter the name of the database" "Press 2 to go back to the Main Menu"
do
echo -e "1- Press 1 to enter database name\n2- Press 2 to go back to Main Menu"
echo "Please choose one of the option: "
read answer
clear
	case $answer in 
	1) while [[ flag -eq 0 ]]
		do
		echo "Please enter the name of the database, press 0 for Main Menu"
		read databaseName
	   		case $databaseName in
				+([a-zA-Z_]*[a-zA-Z0-9_]))
					if [ -d ./Databases/$databaseName ]
					then 
						echo "This database already exists"
					else
						let flag++
						clear
						echo "======================================"
						echo "$databaseName database created successfully!"
						echo "======================================"
						mkdir -p ./Databases/$databaseName	
						break
					fi
							;;
				0) . ./main.sh
							;;
				*) echo "invlid name! Please choose another name"
							;;
			esac
		done
		let flag=0
			;;
	2) . ./main.sh
			;;
	*) clear 
		echo "Invalid option"
			;;
	esac
done
