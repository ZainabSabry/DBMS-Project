#!/bin/bash
clear

echo "===================="
echo "Available Tables:"
ls -1 ./Databases/$dbname
echo "===================="

typeset -i flag3
flag3=0
while [[ $flag3 -eq 0 ]]
do
echo -e "For Previous Menu, Press 0"
read answer
case $answer in 
	0) let flag3++ 
	. ./second.sh
		;;
	*) echo "Invalid Option!"
		;;
esac
done
let flag3=0

