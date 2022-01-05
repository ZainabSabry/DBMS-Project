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
#If there are tables, then list them and choose which to drop
#List the available ones	
else
echo "===================="
echo "Available Tables:"
ls -1 ./Databases/$dbname
echo "===================="

#Ask the user to enter the name of the table
while true
do
echo  "Please enter the table name, For Previous Menu, Press 0 "
read tableName
	case $tableName in
		+([a-zA-Z_]*[a-zA-Z0-9_]))	
			if [ -f ./Databases/$dbname/$tableName ]
			then 
            clear
            while true
            do
				echo "Are you sure you want to delete $tableName table! [yes|no]?"
				read areYouSure
				case ${areYouSure,,} in
					"yes" | "y") rm  ./Databases/$dbname/$tableName
                                clear
								echo "$tableName is Successfully Deleted!"
								echo "===================="
								echo "Available Tables:"
								ls -1 ./Databases/$dbname
								echo "===================="
                                break
										;;
				    "no" | "n") . ./dropTable.sh
										;;
						*) echo "Invalid Option!"
										;;
				esac
                done
			else
				echo "This table does not exist!"
			fi
							;;
		0) . ./second.sh
							;;
		*) echo "Invalid input!"
							;;
	esac

done
fi