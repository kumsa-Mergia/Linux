#!/bin/bash

: <<'END_COMMENT'
mynum=500

if [ $mynum -gt 200 ]
then
	echo "The condition is True."
else
	echo  "The variable does not equal to 200."
fi
END_COMMENT

 :<<'END_COMMENT'
# ******************************************************************************

# USED TO CHECK IF THE FILE ARE THERE OR NOT

if [ -f /home/kumsa/Desktop/Linux-Project/myfile ]
then
echo "The File Exists"
else
	echo "The Fil does not Exist"
fi

END_COMMENT
# ********************************************************************************

:<<'END_COMMENT'
# ==================================================================================

# This is  used to check the program and if there run and if there is not install it
command=/usr/bin/htop

if [ -f $command ]
then
	echo "$command is available, let's run it ....."
else
	echo "$command is NOT available, installing it ..."
	sudo apt update && sudo apt install -y htop
fi

$command

END_COMMENT
# ===================================================================================

program=htop

if command -v $program
then
        echo "$command is available, let's run it ....."
else
        echo "$command is NOT available, installing it ..."
        sudo apt update && sudo apt install -y $program
fi

$program




# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#:<<'END_COMMENT'
package=htop

sudo apt install $packag >> package_install_results.log

if [ $? -eq 0 ]
then 
	echo "The installation of $package was Successfull."
	echo "The New command is available here:"
	which $package
else
	echo "$package failed to install." >> package_install_failure.log
fi
END_COMMENT

# ================================================================================









