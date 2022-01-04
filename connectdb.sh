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
		if [ -d ./Databases/$dbname ]
		then 
			let flag2++
			. ./second.sh
			echo "You are now connected to $dbname"
		elif [ $dbname -eq 0 ]
			then 
				. ./main.sh
		else
			clear
			echo "Invalid database name!"
			while true 
			do
				
				echo -e "1- Enter Another Name\n2-Go Back to Main Menu"
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
done
let flag2=0
