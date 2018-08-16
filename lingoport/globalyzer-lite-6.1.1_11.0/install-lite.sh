#!/bin/bash
#
# The log4j.properties file needs to be "installed" on the current machine
# by replacing ${user.home} with environment variable HOME
#

#
# Make sure environment variable HOME is set
#
if [  -z "$HOME" ]; then
        echo "HOME variable is not set - Globalyzer Lite installation failed"
		exit 1
else
        newHome=$HOME
fi

#
# Perform the replacement
#
script_location=$(dirname "$(readlink -f "$0")")

sed -i "s|\${user.home}|$newHome|g" "${script_location}/log4j.properties"

if [ $? -eq 0 ]; then
  echo "Globalyzer Lite installation completed successfully"
else
  echo "Failed to fill out \${user.home} in ${script_location}/log4j.properties"
fi
