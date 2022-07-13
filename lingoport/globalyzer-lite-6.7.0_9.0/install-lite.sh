#!/bin/bash
#
# The log4j2.xml file needs to be "installed" on the current machine
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
# readlink -f doesn't work on the mac, so this is a replacement ...
#
canonicalize_path() {
    if [ -d "$1" ]; then
        _canonicalize_dir_path "$1"
    else
        _canonicalize_file_path "$1"
    fi
}

_canonicalize_dir_path() {
    (cd "$1" 2>/dev/null && pwd -P)
}

_canonicalize_file_path() {
    local dir file
    dir=$(dirname -- "$1")
    file=$(basename -- "$1")
    (cd "$dir" 2>/dev/null && printf '%s/%s\n' "$(pwd -P)" "$file")
}

#
# Set script location
#
pth="$(canonicalize_path $0)"
script_location=$(dirname "$pth")

#
# Perform the replacement (sed works differently on mac, too)
#
sed -i'.bak' -e "s|\${user.home}|$newHome|g" "${script_location}/log4j2.xml"
rm -f ${script_location}/log4j2.xml.bak

if grep -q "\${user.home}" ${script_location}/log4j2.xml ; then
  echo "Failed to fill out \${user.home} in ${script_location}/log4j2.xml"
else
  echo "Globalyzer Lite installation completed successfully"
fi
