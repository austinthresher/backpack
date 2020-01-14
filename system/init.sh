#!/bin/bash

export BP_BACKPACK_PATH="$HOME/.backpack"
__BACKPACK_PATHS=( bin src pkg tar bpfs installed avail system )
for p in ${__BACKPACK_PATHS[@]}; do
	__CAPS=$(echo $p | tr '[:lower:]' '[:upper:]')
	__VARNAME="BP_${__CAPS}_PATH"
	export "$__VARNAME=$BP_BACKPACK_PATH/$p"
	mkdir -p "$BP_BACKPACK_PATH/$p"
done

export PATH="$BP_BIN_PATH:$PATH"
export BP_PATHS_INITIALIZED=true
