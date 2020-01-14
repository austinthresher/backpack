#!/bin/bash

function link-to-root {
	cd "$BP_CURRENT_PKG"
	for d in $(dirname $(find .)); do
		mkdir -p "$BP_BPFS_PATH/$d"
	done
	for f in $(find .); do
		if [ -f "$BP_CURRENT_PKG/$f" ]; then
			rm -f "$BP_BPFS_PATH/$f" #TODO: something better than overwrite
			ln -s "$BP_CURRENT_PKG/$f" "$BP_BPFS_PATH/$f"
		fi
	done
	# for each file in the package's bin directory, make a script that sets
	# environment variables and then calls that executable
	if [ -d "$BP_CURRENT_PKG/bin" ]; then
		for f in $(find "$BP_CURRENT_PKG/bin"); do
			if [ -f "$f" ]; then
				local name=$(basename "$f")
				rm -f "$BP_BIN_PATH/$name"
				local script="$BP_BIN_PATH/$name"
				echo "#!/bin/bash" > "$script"
				echo "LD_LIBRARY_PATH=\"$BP_BPFS_PATH/lib/\" \\" >> "$script"
				echo "PKG_CONFIG_PATH=\"$BP_BPFS_PATH/lib/pkgconfig/\" \\" >> "$script"
				echo "PATH==\"$BP_BIN_PATH:$PATH\" \\" >> "$script"
				echo "$f \"\$@\"" >> "$script"
				chmod +x "$script"
			fi
		done
	fi
}

export -f link-to-root
