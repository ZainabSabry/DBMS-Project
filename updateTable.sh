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
		+([a-zA-Z_]*[a-zA-Z0-9_]))	
			clear
			if [ -f ./Databases/$dbname/$tableName ]
			then
			#----------------------------------------------------------
			#All the data we need to ask the user of the primary key

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
			cat ./Databases/$dbname/$tableName 
			echo -e "=======================================\n"
			echo "Please insert the primary key, for the previous menu, press 0"
			read primary
			#First we check if this primary key is already there
			if [[ " ${allPK[@]} " =~ " ${primary} " ]]
					then
					clear
                	if [[ "$pkData" =~ "string" ]]
						then 
							case $primary in
								+([a-zA-Z_]*[a-zA-Z0-9_*@-]) | +([a-zA-Z])) clear
											primaryVar=$primary
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
								primaryVar=$primary
								break
									;;
								0) . ./second.sh
									;;
								*) clear
									echo "invalid data type!"
									;;
							esac
					fi
			elif [[ $primary == 0 ]]
                then
                	. ./second.sh
			else
                clear
                echo "Invalid input! This primary does not exist"
			
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

            #-------------------------------------------------------------
            #We ask the user which column he wants to update
			typeset -i flagg
			flagg=0
            while [[ flagg -eq 0 ]]
            do
             #Print to the user the whole record
                echo -e "Here is the record you want to update:\n"
                echo "========================================================"
                sed -n '1p' ./Databases/$dbname/$tableName
                sed -n "/^$primaryVar :/p" ./Databases/$dbname/$tableName
            
                echo "========================================================" 
                echo -e "\nPlease enter the name of the column you want to update: "
				echo "For the previous Menu, Press 0"
                read columnToBeUpdated
				if [[ $columnToBeUpdated == 0 ]]
					then
						. ./second.sh
				fi

                if [[ " ${cols[@]} " =~ " ${columnToBeUpdated} " ]]
                 then
                    #Data type of the column
                    typeset -i index
                    for (( i=1;i<=$colNum;i++ ))
			        do
                        if [[ "${cols[$i]}" =~ "${columnToBeUpdated}" ]]
                        then
                            index=$i
                            colData=${dataTypes[$index]}
                            break
                            
                        fi
			        done
                    #echo $colData

                    #increment the index by one since the record includes the primary key while the datatypes do not!
                    let index++
                    #Get the old value
                    numOfLine=`sed -n "1 ,/^$primary/p" ./Databases/$dbname/$tableName | wc -l`
                    #echo $numOfLine
                    oldValue=`head -$numOfLine ./Databases/$dbname/$tableName | tail -1 | cut -d: -f$index`
                    #echo $oldValue
        
                    #----------------------------------------------------------
                    clear
                    while true
                    do
                    echo "Please enter the new value:"
					echo "For the Previous Menu, Press Enter"
                    read newValue
					newVal=" "$newValue" "

                    if [[ "$colData" =~ "string" ]]
                        then
                          case $newValue in
					        +([a-zA-Z_]*[a-zA-Z0-9_*@-]) | +([a-zA-Z])) clear
								sed -i -e "/^$primaryVar/s/$oldValue/$newVal/" ./Databases/$dbname/$tableName
								echo "The record has successfully been updated!"
								sed -n '1p' ./Databases/$dbname/$tableName
               					sed -n "/^$primaryVar :/p" ./Databases/$dbname/$tableName
								sleep 3
									let flagg++
								    break
								    ;;
					        "")	clear 
								while true
								do
								echo "By going back to the previous menu, this update will not be added! [yes or no]?"
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
                         case $newValue in
					        +([1-9]*[0-9]) | +([1-9])) clear
						        sed -i -e "/^$primaryVar/s/$oldValue/$newVal/" ./Databases/$dbname/$tableName
								echo "The record has successfully been updated!"
								sed -n '1p' ./Databases/$dbname/$tableName
               					sed -n "/^$primaryVar :/p" ./Databases/$dbname/$tableName
								sleep 3
										let flagg++
						                break
						        	;;
					        0) clear 
							while true
								do
								echo "By going back to the previous menu, this update will not be added! [yes or no]?"
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
                else
                    clear
                    echo "There is no such column"
                fi
            done

				#-------------------------------------------------------------------------------------------------------------
			#Now we let the user decide whether to go back to the previous menu, edit another column or another table
			clear
			while true 
			do
				echo -e "1- Update another table\n2- Go Back to Previous Menu"
				echo "Please choose one of the options:"
				read option
				case $option in
					1) . ./updateTable.sh	
						    ;;
                    2) clear
                        #Print the whole table with cat and give him the choice between inserting another record or going back to the previous menu
			            echo "========================================================="
			            echo -e "\t Table: $tableName"
			            cat ./Databases/$dbname/$tableName | sed '2d'
			            echo "========================================================="
			            sleep 3
			            . ./second.sh
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

