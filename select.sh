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

select one in "Select a Table" "Select a Record" "Previous Menu"
do
    case $REPLY in
    #-------------------------------------------------------------------
    #Select a whole table
        1) clear
        while true
        do
            #If there are tables, then list them and choose which one to select
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
                        if [ -f ./Databases/$dbname/$tableName ]
                            then
                                clear
                                echo "========================================================="
                                echo -e "\t Table: $tableName"
                                cat ./Databases/$dbname/$tableName | sed '2d'
                                echo "========================================================="
                                #What to do next
                                while true
                                do
                                    echo -e "\n1- To select another table\n2- To Go Back to the Previous Menu"
                                    read option
                                    case $option in
                                        1) . ./select.sh
                                            ;;
                                        2) . ./second.sh
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
		            *) echo "Invalid input!"
							;;
	            esac
            done
                    ;;

        #-------------------------------------------------------           
        #Select One Record
        2) clear
            while true
            do
			#If there are tables, then list them and choose which one to select
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
                                #First we check if this primary key is already there
                                    if [[ " ${allPK[@]} " =~ " ${primary} " ]]
                                        then
                                            clear
                                            if [[ "$pkData" =~ "string" ]]
                                                then 
                                                    case $primary in
                                                        +([a-zA-Z_]*[a-zA-Z0-9_*@]) | +([a-zA-Z])) clear     
                                                            echo "========================================================"
                                                            sed -n '1p' ./Databases/$dbname/$tableName
                                                            sed -n "/^$primary :/p" ./Databases/$dbname/$tableName
                                                            echo "========================================================"
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
                                                        echo "========================================================"
                                                        sed -n '1p' ./Databases/$dbname/$tableName
                                                        sed -n "/^$primary :/p" ./Databases/$dbname/$tableName
                                                        echo "========================================================"
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

                                #What to do next
                                while true
                                do
                                    echo -e "\n1- To select another record\n2- To Go Back to the Previous Menu"
                                    read option
                                    case $option in
                                        1) . ./select.sh
                                            ;;
                                        2) . ./second.sh
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
		            *) echo "Invalid input!"
							;;
                esac
            done
                    ;;
        3) . ./second.sh
                    ;;    

    esac
done
fi



