#!/bin/bash
typeset -i flag5
flag5=0
while [[ flag5 -eq 0 ]]
do
	echo "Please enter the name of the table, press 0 to go to the previous menu"
	read table
	   	case $table in
			+([a-zA-Z_]*[a-zA-Z0-9_]))
				if [ -f ./Databases/$dbname/$table ]
				then 
				clear
					echo "This table already exists"
				else
					let flag5++
					clear
					echo "====================================="
					echo "$table table created successfully!"
					echo "====================================="
					touch ./Databases/$dbname/$table

					#We ask the user to enter the size of the table
					while true
					do
						echo "Please enter the number of columns, For the previous menu, press 0 "
						read size
							case $size in
								+([0-9]))
								if [[ $size == +([0]) ]]
									then
									clear
									while true
									do
									echo "By going back to the previous menu, your table will be deleted! [yes or no]?"
									read YesOrNo
										case ${YesOrNo,,} in
											"yes" | "y") rm ./Databases/$dbname/$table
											clear
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
										else

								
								#Ask the user for the primary key and its data type and store them in variables
								primaryKey=""
								primaryData=""

							while true
							do
							clear
								echo "Please enter the name of the Primary Key, for the previous menu, press 0"
								read PK
								case $PK in
									+([a-zA-Z_]*[a-zA-Z0-9_])) clear
										echo "Primary Key created successfully"
										primaryKey=$PK
										break
												;;
									0) clear 
									while true
									do
									echo "By going back to the previous menu, your table will be deleted! [yes or no]?"
										read YesOrNo
										case ${YesOrNo,,} in
											"yes" | "y") rm ./Databases/$dbname/$table
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
										echo "Invalid name!"
												;;
								esac
								done

								while true
								do
								clear
								echo -e "1- Integer\n2- String"
								echo  "Please choose the primary key data type, for the previous menu, press 0"
								read PKdata
								case $PKdata in
									1)clear 
									primaryData="integer"
									break
									;;
									2) clear 
									primaryData="string"
									break
									;;
									0) clear

									while true
									do
									echo "By going back to the previous menu, your table will be deleted! [yes or no]?"
										read YesOrNo
										case ${YesOrNo,,} in
											"yes" | "y") rm ./Databases/$dbname/$table
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
										echo "Invlid option"
									;;
								esac
							done

							#Ask the user for the name of columns and their data types and store each in an array
							declare -a names=()
							declare -a datatypes=()
							
							for (( i=1;i<$size;i++ ))
							do

							clear

							while true
							do
							echo "Please enter the name of column $(($i+1)), for the previous menu, press 0"
							read colName
							case $colName in
									$PK) clear 
										echo "This column already exists!"
												;;
								+([a-zA-Z_]*[a-zA-Z0-9_])) clear
													if [[  " ${names[@]} " =~ " ${colName} " ]]
    													then 
															clear
        													echo "This column already exists"
    													else
															clear
    														names[$i]=" : "$colName
    														break
													fi
												;;
									0) clear 
									while true 
									do
									echo "By going back to the previous menu, your table will be deleted! [yes or no]?"
										read YesOrNo
										case ${YesOrNo,,} in
											"yes" | "y") rm ./Databases/$dbname/$table
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
										echo "Invalid name!"
												;;
							esac
							done

							while true
							do
								clear
								echo -e "1- Integer\n2- String"
								echo  "Please choose the data type for column $(($i+1)), for the previous menu, press 0"
								read coldata
								case $coldata in
									1) clear 
									datatypes[$i]=" : integer"
									break
									;;
									2) clear 
									datatypes[$i]=" : string"
									break
									;;
									0) clear
									while true
									do
									echo "By going back to the previous menu, your table will be deleted! [yes or no]?"
										read YesOrNo
										case ${YesOrNo,,} in
											"yes" | "y") clear 
												rm ./Databases/$dbname/$table
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
										echo "Invlid option"
									;;
								esac
							done
							done
							#Print here the name of the table created and the columns and their data types
							clear
							echo "=================================================="
							echo "You have successfully created the [$table] table!"
							echo $primaryKey  ${names[@]} > ./Databases/$dbname/$table 
							sed -i  "1 a $primaryData ${datatypes[*]}" ./Databases/$dbname/$table 
							cat ./Databases/$dbname/$table 
							echo "=================================================="
							sleep 3
							. ./second.sh
							break
							fi						
										;;
								0) . ./second.sh
										;;
								*) clear
									echo "invalid number"
										;;
							esac
					done	
				fi
							;;
			0) . ./second.sh
							;;
			*) clear
				echo "invlid name! Please choose another name"
							;;
		esac
done
let flag5=0
