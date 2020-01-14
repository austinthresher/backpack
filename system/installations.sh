#!/bin/bash

# mark-installed <package-name>
# Creates an entry in $BP_INSTALLED_PATH to indicate the named package is installed
function mark_installed {
    if [ ! -e "$BP_INSTALLED_PATH/$1" ]; then
	touch "$BP_INSTALLED_PATH/$1"
    fi
}

export -f mark_installed

# mark-installed <package-name>
# Removes an entry in $BP_INSTALLED_PATH to indicate the named package is not installed
function mark_uninstalled {
    if [ -e "$BP_INSTALLED_PATH/$1" ]; then
	rm "$BP_INSTALLED_PATH/$1"
    fi
}

export -f mark_uninstalled
