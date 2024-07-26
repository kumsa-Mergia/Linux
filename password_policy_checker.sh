#!/bin/bash

# Check if the script is being run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root" 
    exit 1
fi

# Display the password policy
echo "Password Policy:"
echo "----------------"
grep -E "PASS_MAX_DAYS|PASS_MIN_DAYS|PASS_MIN_LEN|PASS_WARN_AGE" /etc/login.defs

# Display password complexity settings
echo "Password Complexity Settings:"
echo "------------------"
grep -E "minlen|minclass" /etc/security/pwquality.conf
