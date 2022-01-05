#!/bin/bash
clear
echo "You are now connected to $answer"
select option in "Create Table" "List Tables" "Drop Table" "Insert into table" "Select from Table" "Delete from Table" "Update Table" "Go Back to Main Menu" "Exit"
do
	case $REPLY in
		1) . ./createTable.sh
			;;
		2) . ./listTables.sh
			;;
		3) . ./dropTable.sh
			;;
		4) . ./insert.sh
			;;
		5) . ./select.sh
			;;
		6) . ./delete.sh
			;;
		7) . ./updateTable.sh
			;;
		8) . ./main.sh
			;;
		9) exit
			;;
		*) echo  "Invalid Option! Please choose again"
			;;
	esac
done
