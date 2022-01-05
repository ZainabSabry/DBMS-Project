#!/bin/bash
clear

#check if the database has any tables at all
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
#If there are tables, then list them and choose which one to insert into
#List the available ones
echo "===================="
echo "Available Tables:"
ls -1 ./Databases/$dbname
echo "===================="
#Ask the user to enter the name of the table
echo  "Please enter the table name, For Previous Menu, Press 0 "
read tableName
	case $tableName in
		+([a-zA-Z_]*[a-zA-Z0-9_*@]))
			clear
			if [ -f ./Databases/$dbname/$tableName ]
			then
			#----------------------------------------------------------
			#All the data we need to ask the user fo the primary key
			#the array to which the values will be added to echo them later on -> record
            declare -a record=()
			#capture the data type of the primary key
			pkData=`head -2 ./Databases/$dbname/$tableName | tail -1 | cut -d: -f1`

			#to save the number of existing primary key, NR using awk END or cat and wc
			#instead of substracting anything, I will just i at 2
			typeset -i numPK 
			numPK=`cat ./Databases/$dbname/$tableName | wc -l`

			#capture the existing primary keys to compare the new one against them
			#when looping the i will be with the head not the cut
			declare -a allPK=()
			for (( i=3;i<=$numPK;i++ ))
			do 
				allPK[$i]=`head -$i ./Databases/$dbname/$tableName | tail -1 | cut -d: -f1`
			done
			
			#Now we ask the user for the primary key
			clear
			while true
			do 
			echo -e "======================================="
			sed -n '1,2p' ./Databases/$dbname/$tableName 
			echo -e "=======================================\n"
			echo "Please insert the primary key, for the previous menu, press 0"
			read primary
			#First we check if this primary key is already used
			if [[ " ${allPK[@]} " =~ " ${primary} " ]]
			then
				clear
				echo "Invalid input! The Primary Key has to be unique!"
			else
			if [[ "$pkData" =~ "string" ]]
			then 
				case ${primary,,} in
					+([a-zA-Z_]*[a-zA-Z0-9_*@-]) | +([a-zA-Z])) clear
								record[0]=$primary
								break
								;;
					0) . ./second.sh
								;;
					*) clear
					echo "invalid input!"
								;;
				esac

				else
				case $primary in
					+([1-9]*[0-9]) | +([1-9])) clear
						record[0]=$primary
						break
							;;
					0) . ./second.sh
							;;
					*) clear
					 echo "invalid data type!"
							;;
				esac
				fi
				fi
			done

			#-----------------------------------------------------
			#Now, we move to the other columns
			#capture the number of columns using awk
			typeset -i colNum
			read colNum <<< $(awk -F: '{if(NR == 1)print NF}' ./Databases/$dbname/$tableName)
			#capture the names of columns
			declare -a cols=()
			for (( i=1;i<=$colNum;i++ ))
			do
				cols[$i-1]=`head -1 ./Databases/$dbname/$tableName | cut -d: -f$i`
			done
			
			#capture the data types of columns
			declare -a dataTypes=()
			for (( i=1;i<=$colNum;i++ ))
			do
				dataTypes[$i-1]=`head -2 ./Databases/$dbname/$tableName | tail -1 | cut -d: -f$i`
			done
			#echo ${dataTypes[@]}

			#-------------------------------------------------------------------------------------------------------------
			#after the primary key, I will let the user decide whether to go back to the previous menu or insert into the other columns
			while true 
			do
				echo -e "1- Insert into the other columns\n2-Go Back to Previous Menu"
				echo "Please choose one of the options:"
				read option
				case $option in
					1) clear 
						break
						;;
					2) clear
						while true
						do
						echo "By going back to the previous menu, All the other columns will be assigned NULL! [yes or no]?"
						read YesOrNo
						case ${YesOrNo,,} in
							"yes" | "y") clear
										for (( i=1; i<$colNum;i++ ))
										do 
											record[$i]=" : NULL"
										done 
										echo ${record[@]} >> ./Databases/$dbname/$tableName
										. ./second.sh	
												;;
							"no"  | "n") clear
										break
												;;
							*) clear
								echo "Invalid Option!"
												;;
						esac
						done
						;;
					*) clear
						echo "Invalid Option!"
						;;
				esac
			done

			#-------------------------------------------------------------
			#Ask the user to enter the other columns
			#If the user wants to leave one column empty, he can press space
			#if during inserting into the record, he asks to leave, he will be prompt that nothing will be saved
			clear
			for (( i=0;i<$colNum-1;i++ ))
			do
				while true
				do
				echo "========================================="
				sed -n '1,2p' ./Databases/$dbname/$tableName 
				echo -e "=======================================\n"
				echo "Please insert the ${cols[$i+1]}, to leave this column NULL, please press Enter"
				echo "For the previous menu, press 0"
				read colValue
				if [[ "${dataTypes[$i+1]}" =~ "string" ]]
			then 
				case $colValue in
					+([a-zA-Z_]*[a-zA-Z0-9_*@-]) | +([a-zA-Z])) clear
								record[$i+1]=" : $colValue"
								break
								;;
					"") clear
						record[$i+1]=" :  NULL"
						break
								;;
					0) clear 
					while true
						do
						echo "By going back to the previous menu, this record will not be added! [yes or no]?"
						read YesOrNo
						case ${YesOrNo,,} in
							"yes" | "y") clear
										. ./second.sh	
												;;
							"no"  | "n") clear
										break
												;;
							*) clear
								echo "Invalid Option!"
												;;
						esac
						done
					
								;;
					*) clear
					echo "invalid input!"
								;;
				esac
				else
				case $colValue in
					+([1-9]*[0-9]) | +([1-9])) clear
						record[$i+1]=" : $colValue"
						break
							;;
					"") clear
						record[$i+1]=" :  NULL"
						break
							;;
					0) clear 
					while true
						do
						echo "By going back to the previous menu, this record will not be added! [yes or no]?"
						read YesOrNo
						case ${YesOrNo,,} in
							"yes" | "y") clear
										. ./second.sh	
												;;
							"no"  | "n") clear
										break
												;;
							*) clear
								echo "Invalid Option!"
												;;
						esac
						done
							;;
					*) clear
					 echo "invalid data type!"
							;;
				esac
				fi

				done
			done
			#Now we print all values to the table
			echo ${record[@]} >> ./Databases/$dbname/$tableName

			#Print the whole table with cat and give him the choice between inserting another record or going back to the previous menu
			echo "========================================================="
			echo -e "\t Table: $tableName"
			cat ./Databases/$dbname/$tableName | sed '2d'
			echo "========================================================="
			sleep 3
			. ./second.sh
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

