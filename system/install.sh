#!/bin/bash

# install <package-name>
function install {
    set -e
    if [ "$BP_PATHS_INITIALIZED" != true ]; then
        fatal "call initialize_paths before install"
    fi
    local BP_PARENT_NAME="${BP_PACKAGE_NAME:-backpack}"
    export BP_PACKAGE_NAME="$1"
    if [ ! -e "$BP_AVAIL_PATH/$BP_PACKAGE_NAME" ]; then
        fatal "no install script found named '$BP_PACKAGE_NAME'"
    fi
    export BP_CURRENT_PKG="$BP_PKG_PATH/$BP_PACKAGE_NAME"
    mkdir -p "$BP_CURRENT_PKG"
    set_trap
    source "$BP_AVAIL_PATH/$BP_PACKAGE_NAME"
    mark_installed "$BP_PACKAGE_NAME"
    clear_trap
    export BP_PACKAGE_NAME="$BP_PARENT_NAME"
}

export -f install
