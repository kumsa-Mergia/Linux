#!/bin/bash

echo "Welcome $USER "
echo "==============================="

	echo "1 - Create Directory "
	echo "2 - Create File "
 	echo "3 - Remove "
read choice

case $choice in

	1) echo "Enter The Folder Name: "
		read fo_name
		mkdir $fo_name
		echo ""The File $fo_name is Successfully Created  "
		ls -l;;

	 2) echo "Enter The File Name: "
        	read fo_name
        	mkdir $fo_name
        	echo "The File $fi_name is Successfully Created "
        	ls -l;;

	 3) echo "Enter The File/Folder Name you want to Remove "
	        read rm_name
        	rm -rf $rm_name
        	echo "The File $rm_name is Successfully Removed "
        	ls -l;;

	*) echo "Sorry!! You didn't enter approprate Number: "

esac 
echo " "
echo "============================================="
echo "Thank You $USER "
