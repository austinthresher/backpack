#!/bin/bash

# verify <file-in-bpfs>
# Used to confirm if a build completed successfully or not. Asserts
# that <file-in-bpfs> exists, which should only be true if link_to_root
# ran successfully.
function verify {
	echo -n "verifying file '$BP_BPFS_PATH/$1' was installed... "
	if [ ! -f "$BP_BPFS_PATH/$1" ]; then
		fatal "failed to verify file '$BP_BPFS_PATH/$1'"
	fi
}

export -f verify
