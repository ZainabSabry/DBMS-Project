#!/bin/bash
clear

#check if the directory has any tables at all
if [ -z "$(ls -A ./Databases/$dbname)" ]
then 
	echo "There are no tables available! Press any key for Previous Menu"
	read option
	case $option in
	*) . ./second.sh
		;;
	esac	
else

while true
do
#If there are tables, then list them and choose which to drop
#List the available ones
echo "===================="
echo "Available Tables:"
ls -1 ./Databases/$dbname
echo "===================="

#Ask the user to enter the name of the table
echo  "Please enter the table name, For Previous Menu, Press 0 "
read tableName
	case $tableName in
		+([a-zA-Z_]*[a-zA-Z0-9_]))	clear
			if [ -f ./Databases/$dbname/$tableName ]
			then 
            clear
            while true
            do
				echo "Are you sure you want to delete $tableName table! [yes|no]?"
				read areYouSure
				case ${areYouSure,,} in
					"yes" | "y") clear 
								rm  ./Databases/$dbname/$tableName
                                clear
								echo "$tableName is Successfully Deleted!"
								echo "===================="
								echo "Available Tables:"
								ls -1 ./Databases/$dbname
								echo "===================="
                                sleep 3
								clear
								#What to do next
								while true 
								do
									echo -e "1- Drop Another Table\n2- Go Back to Previous Menu"
									echo "Please choose one of the options:"
									read option
										case $option in
											1). ./dropTable.sh
												;;
											2) . ./second.sh
												;;
											*) clear
												echo "Invalid Option!"
												;;
										esac
								done
										;;
				    "no" | "n") . ./dropTable.sh
										;;
						*) clear
							echo "Invalid Option!"
										;;
				esac
                done
			else
			clear
				echo "This table does not exist!"
			fi
							;;
		0) . ./second.sh
							;;
		*) clear
			echo "Invalid input!"
							;;
	esac

done
fi