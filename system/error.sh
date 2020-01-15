#!/bin/bash

function print_log_trap {
	local name="$1"
	print_divider 64 = &> /dev/tty
	echo "Error on line $(caller)" &> /dev/tty
	echo "Log:" &> /dev/tty
	tail "$BP_LOGS_PATH/$name" | sed -e 's/^/\t/g' &> /dev/tty
	fatal "install failed for package $name"
}
export -f print_log_trap

function set_trap {
	trap 'print_log_trap "$BP_PACKAGE_NAME"' ERR
	set -e
}
export -f set_trap

function clear_trap {
	trap - ERR
}
export -f clear_trap


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
