#!/bin/bash
clear
typeset -i flag
flag=0
while [[ flag -eq 0 ]]
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
					echo "==================================================="
					echo "$databaseName database created successfully!"
					echo "==================================================="
					mkdir -p ./Databases/$databaseName	
					sleep 3
					clear
					#What to do next
					while true 
					do
						echo -e "1- Create Another Database\n2- Go Back to Main Menu"
						echo "Please choose one of the options:"
						read option
							case $option in
								1). ./createdb.sh
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
				echo "invlid name! Please choose another name"
							;;
esac
done

