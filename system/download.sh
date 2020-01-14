#!/bin/bash

# download <file-url>
# Downloads the file at <file-url> to $BP_TAR_PATH and sets $BP_ARCHIVE_PATH
function download {
	if [ "$BP_PATHS_INITIALIZED" != true ]; then
		echo "ERROR: call initialize_paths before download"
		return 1
	fi

	local src="$1"
	local dst="$BP_TAR_PATH/${1##*/}"
	if which wget &> /dev/null  && [ -x "$(which wget)" ]; then
		wget -O "$dst" "$src" --no-check-certificate
	elif which perl &> /dev/null  && [ -x "$(which perl)" ]; then
		perl -MLWP::Simple -e "getstore \"$src\", \"$dst\""
	elif which curl &> /dev/null && [ -x "$(which curl)" ]; then
		curl -L "$src" -o "$dst" --insecure
	else
		echo "No download utility found. Setup cannot continue."
		return 1
	fi
	export BP_ARCHIVE_PATH="$dst"
}

export -f download

function checkout {
	cd "$BP_SRC_PATH"
	if [ ! -d "$BP_PACKAGE_NAME" ]; then
		git clone "$1" "$BP_PACKAGE_NAME"
	fi
	cd "$BP_PACKAGE_NAME"
	export BP_CURRENT_SRC="$BP_SRC_PATH/$BP_PACKAGE_NAME"
}
export -f checkout
