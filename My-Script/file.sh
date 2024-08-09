#!/bin/bash


:<<'END_COMMENT'
directory=/etc

if [ -d $directory ]
then
	echo "The Directory $directory exists."
	exit 0
else 
	echo "The Directory $directory does't exist."
	exit 199
fi
echo "The exit code for this script run is $?"
echo "you did't see this statement."
echo "you won't see this one either."
END_COMMENT

# ===============================================================================

:<<'END_COMMENT'
myvar=1

while [ $myvar -le 10 ]
do
	echo $myvar
	myvar=$(( $myvar +1 ))
	sleep 0.5
done

END_COMMENT

# ===================================================================================

:<<'END_COMMENT'
# Universal Update Script

release_file=/etc/os-release

if grep -q "Arch" $release_file

then
	# The Host is based on Arch, run the pacman update command
	sudo pacman -Syu
fi

if grep -q "Ubuntu" $release_file || grep -q "Debian" $release_file

then
	# The host is based on Ubuntu or Drebian
	# Run the apt version of the command
	sudo apt update
	sudo apt dist-upgrade
fi

END_COMMENT

# ========================================================================================

for current_number in {1..10}
do 
	echo $current_number
	sleep 1
done
	echo "This is outside of the for loop."
