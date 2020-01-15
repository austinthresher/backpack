#!/bin/bash

function configure_flags {
	echo "$@ --prefix=$BP_CURRENT_PKG"
}

export -f configure_flags

function make_flags {
	if which nproc &> /dev/null; then
		# Only use half of what's available
		local p=$(nproc)
		local n=$(($p/2))
		if (($n<1)); then 
			n=1 
		fi
		echo "-j $n $@"
	else
		echo "$@"
	fi
}

export -f make_flags

function cflags {
	echo "$@ -I$BP_BPFS_PATH/include -fPIC"
}

export -f cflags

function ldflags {
	echo "$@ -L$BP_BPFS_PATH/lib"
}

export -f ldflags
