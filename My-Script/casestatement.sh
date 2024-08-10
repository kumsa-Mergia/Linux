#!/bin/bash


:<<'END_COMMENT'

echo "________________________________________________________"
echo "________________  Hello $user __________________________"

echo "What is Your favourite linux distribution."

echo "1 - Arch"
echo "2 - CentOS"
echo "3 - Debian"
echo "4 - Mint"
echo "5 - Ubuntu"
echo "6 - Something else ...."

echo "________________________________________________________"
echo " "

read distro;

case $distro in

	1) echo "Arch is a rolling release.";;
	2) echo "CentOS is Popular on servers.";;
	3) echo "Debian is a community Distribution.";;
	4) echo "Mint is Popular on Desktop and Laptops.";;
	5) echo "Ubuntu is Popular on both servers and computers.";;
	6) echo "There are many Distributions out there.";; 
	*) echo "You didn't enter an appropriate choice."
esac
echo "" 

echo "________________________________________________________"

END_COMMENT
 # ==================================================================================================


:<<'END_COMMENT'

finished=0

while [ $finished -ne 1 ]
do
	echo "What is Your favourite linux distribution."

	echo "1 - Arch"
	echo "2 - CentOS"
	echo "3 - Debian"
	echo "4 - Mint"
	echo "5 - Ubuntu"
	echo "6 - Something else ...."
	echo "7 - Exit the Script."
	echo "________________________________________________________"

	read distro;


	case $distro in

	        1) echo "Arch is a rolling release.";;
        	2) echo "CentOS is Popular on servers.";;
        	3) echo "Debian is a community Distribution.";;
        	4) echo "Mint is Popular on Desktop and Laptops.";;
      	        5) echo "Ubuntu is Popular on both servers and computers.";;
                6) echo "There are many Distributions out there.";;
		7) finished=1 ;;
       		*) echo "You didn't enter an appropriate choice."
	esac
done
echo "Thank you for using this script."

echo "________________________________________________________"

END_COMMENT

# =============================================================================================
