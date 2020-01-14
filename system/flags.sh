#!/bin/bash

function configure-flags {
	echo "--prefix=$BP_CURRENT_PKG"
}

export -f configure-flags

function cflags {
	echo "$@ -I$BP_BPFS_PATH/include -fPIC"
}

export -f cflags

function ldflags {
	echo "$@ -L$BP_BPFS_PATH/lib"
}

export -f ldflags
