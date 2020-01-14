#!/bin/bash
if [ ! -f "system/init.sh" ]; then
	echo "please run this from the root directory of the repository"
	exit 1
fi

case "$1" in
	-v|--verbose)
		set -x
		;;
esac

source system/init.sh
cp system/* "$BP_SYSTEM_PATH/"
cp bin/* "$BP_BIN_PATH/"
cp packages/* "$BP_AVAIL_PATH/"
mv "$BP_SYSTEM_PATH/init.sh" "$HOME/.bpinit"
