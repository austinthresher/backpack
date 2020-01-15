#!/bin/bash

function configure_flags {
	echo "$@ --prefix=$BP_CURRENT_PKG"
}

export -f configure_flags

function make_flags {
	if which nproc; then
		# Only use half of what's available
		local n=$(($(nproc)/2))
		(($n<1)) && n=1
		echo "-j $n $@"
	else
		echo "$@"
	fi
}

function cflags {
	echo "$@ -I$BP_BPFS_PATH/include -fPIC"
}

export -f cflags

function ldflags {
	echo "$@ -L$BP_BPFS_PATH/lib"
}

export -f ldflags
