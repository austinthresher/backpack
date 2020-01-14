#!/bin/bash

# extract
# Extracts the file at $BP_ARCHIVE_PATH to $BP_SRC_PATH/$BP_PACKAGE_NAME
function extract {
	if [ "$BP_PATHS_INITIALIZED" != true ]; then
		echo "ERROR: call initialize_paths before extract"
		return 1
	fi
	if [ -z "$BP_ARCHIVE_PATH" ]; then
		echo "ERROR: call download before extract"
		return 1
	fi
	if [ ! -f "$BP_ARCHIVE_PATH" ]; then
		echo "ERROR: '$BP_ARCHIVE_PATH' file not found"
		return 1
	fi
	if [ -z "$BP_PACKAGE_NAME" ]; then
		echo "ERROR: set BP_PACKAGE_NAME before extract"
		return 1
	fi

	export BP_CURRENT_SRC="$BP_SRC_PATH/$BP_PACKAGE_NAME"
	# If a src directory already exists, move it to start anew
	if [ -d "$BP_CURRENT_SRC" ]; then
		mv "$BP_CURRENT_SRC" "$BP_SRC_PATH/.$BP_PACKAGE_NAME.$(date +f%s)"
	fi
	mkdir "$BP_CURRENT_SRC"
	cd "$BP_CURRENT_SRC"
	tar -xf "$BP_ARCHIVE_PATH"
	local nf=$($(which ls) -1 | wc -l)
	ls
	if [ "$nf" -eq 1 ]; then
		local dirname=$($(which ls) -1)
		# The archive's contents were in a single directory
		cd "$BP_SRC_PATH"
		mv "$BP_CURRENT_SRC/$dirname" "$BP_SRC_PATH/$dirname"
		rmdir "$BP_CURRENT_SRC"
		mv "$BP_SRC_PATH/$dirname" "$BP_CURRENT_SRC"
	fi
	cd "$BP_CURRENT_SRC"
}

export -f extract
