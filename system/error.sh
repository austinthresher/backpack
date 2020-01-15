#!/bin/bash

function fatal {
	local ret=$?
	if [ "$ret" != 0 ]; then
		>&2 echo "[$ret] FATAL: $1"
		echo "[$ret] FATAL: $1" &> /dev/tty
		exit $ret
	fi
	>&2 echo "FATAL: $1"
	echo "FATAL: $1" &> /dev/tty
	exit 1
}

export -f fatal
