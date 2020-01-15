#!/bin/bash
set -e

# install <package-name>
function install {
    if [ "$BP_PATHS_INITIALIZED" != true ]; then
        echo "ERROR: call initialize_paths before install"
        return 1
    fi
    export BP_PACKAGE_NAME="$1"
    if [ ! -e "$BP_AVAIL_PATH/$BP_PACKAGE_NAME" ]; then
        echo "'$BP_PACKAGE_NAME': no install script found"
        return 1
    fi
    export BP_CURRENT_PKG="$BP_PKG_PATH/$BP_PACKAGE_NAME"
    mkdir -p "$BP_CURRENT_PKG"
    export BP_INSTALL_ERROR=0
    source "$BP_AVAIL_PATH/$BP_PACKAGE_NAME"
    if [ "$BP_INSTALL_ERROR" == 0 ]; then
        mark_installed "$BP_PACKAGE_NAME"
    fi
}

export -f install
