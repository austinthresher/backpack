#!/bin/bash

# Confirm function based on answer at https://stackoverflow.com/a/3232082
function confirm {
	read -r -p "${1:-'Are you sure?'} [y/N] " response
	case "$response" in
		[yY][eE][sS]|[yY])
			true
			;;
		*)
			false
			;;
	esac
}

export -f confirm
