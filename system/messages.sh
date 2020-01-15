#!/bin/bash

function print_header {
	echo "=== BACKPACK V0.1 ==="
}
export -f print_header

function print_command {
	echo ":: $@"
}
export -f print_command

function print_divider {
	local len="$1"
	local char="$2"
	for ((i=0;i<$len;i++)); do
		printf "$char"
	done
	printf "\n"
}
export -f print_divider

# print_indent <tabs>
# prints <tabs> * 4 spaces without a newline
function print_indent {
	local levels="$1"
	local spaces="                                        "
	local __t="${spaces:0:$levels}"
	__t="$__t$__t$__t$__t"
	echo -n "$__t"
}
export -f print_indent


function print_block_opening {
	print_indent "$1"
	shift 1
	echo "$@"
}
export -f print_block_opening

function print_block_contents {
	print_indent "$1"
	shift 1
	echo "-> $@"
}
export -f print_block_contents
