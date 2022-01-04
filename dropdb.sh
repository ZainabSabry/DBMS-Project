#!/bin/bash
clear

#check if the directory has any databases at all
if [ -z "$(ls -A ./Databases)" ]
then 
	echo "There are no databases available! Press any key for Main Menu"
	read option
	case $option in
	*) . ./main.sh
		;;
	esac
#If there are databases, then list them and choose which to drop
#List the available ones	
else
echo "===================="
echo "Available Databases:"
ls -1 ./Databases
echo "===================="

#Ask the user to enter the name of the database
while true
do
echo  "Please enter the database name, For Main Menu, Press 0 "
read answer
	case $answer in
		+([a-zA-Z_]*[a-zA-Z0-9_]))	
			if [ -d ./Databases/$answer ]
			then 
				clear
				while true
				do
				echo "Are you sure you want to delete $answer database! [yes|no]?"
				read areYouSure
				case ${areYouSure,,} in
					"yes" | "y") rm -r ./Databases/$answer
								clear
								echo "$answer is Successfully Deleted!"
								echo "===================="
								echo "Available Databases:"
								ls -1 ./Databases
								echo "===================="
								break
										;;
				    "no" | "n") . ./main.sh
										;;
						*) echo "Invalid Option!"
										;;
				esac
				done
			else
				echo "This database does not exist!"
			fi
							;;
		0) . ./main.sh
							;;
		*) echo "Invalid input!"
							;;
	esac

done
fi
