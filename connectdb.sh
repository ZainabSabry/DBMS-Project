#!/bin/bash
clear
echo "===================="
echo "Available Databases:"
ls -1 ./Databases
echo "===================="


typeset -i flag2
flag2=0
while [[ $flag2 -eq 0 ]]
do			
	echo "Please enter the database name or Press 0 for Main Menu!"
	read dbname
	case $dbname in
		+([a-zA-Z_]*[a-zA-Z0-9_]))	
			#Check if the directory exists or not
			if [ -d ./Databases/$dbname ]
			then 
				echo "You are now connected to $dbname";
				. ./second.sh
				let flag2++
			else
				clear
				echo "This database does not exist!"

				#What to do next
				while true 
				do
					echo -e "1- Enter Another Name\n2- Go Back to Main Menu"
					echo "Please choose one of the options:"
					read option
					case $option in
						1). ./connectdb.sh
							;;
						2) . ./main.sh
							;;
						*) clear
							echo "Invalid Option!"
							;;
					esac
				done
			fi
			;;
		0) . ./main.sh
			;;
		*) clear
			echo "===================="
			echo "Available Databases:"
			ls -1 ./Databases
			echo "===================="
			echo "Invalid input!"
		;;
	esac
done
let flag2=0
