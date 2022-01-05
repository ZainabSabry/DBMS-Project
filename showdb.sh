#!/bin/bash
clear
echo "===================="
echo "Available Databases:"
ls -1 ./Databases
echo "===================="

typeset -i flag3
flag3=0
while [[ $flag3 -eq 0 ]]
do
echo -e "For Main Menu, Press 0"
read answer
case $answer in 
	0) let flag3++ 
	. ./main.sh
		;;
	*) clear
		echo "Invalid Option!"
		;;
esac
done
let flag3=0
