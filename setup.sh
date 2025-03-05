#!/bin/bash

# @author gitofleonardo
# @url https://github.com/gitofleonardo/WinscopeSetup

frameworks_base_repo="https://android.googlesource.com/platform/frameworks/base"
development_repo="https://android.googlesource.com/platform/development"
perfetto_repo="https://android.googlesource.com/platform/external/perfetto"
proto_logging_repo="https://android.googlesource.com/platform/frameworks/proto_logging"
libs_systemui_repo="https://android.googlesource.com/platform/frameworks/libs/systemui"

frameworks_base_repo_targets=("core/proto")
development_repo_targets=("tools/winscope")
libs_systemui_repo_targets=("viewcapturelib/src/com/android/app/viewcapture/proto")

repo_branch="android15-qpr2-release"

exclude_folders=

function repo_path() {
    echo $1 | awk -F '/platform/' '{print $2}'
}

function check_ret() {
    if [[ $? -ne 0 ]]; then
        exit 1
    fi
}

function clone_repo() {
    git clone -b $repo_branch $1 $(repo_path $1) --depth=1
    check_ret
}

function trim_repo_folder() {
    target_folder=$(repo_path $1)
    empty_dir=$(mktemp -d)
    rsync -a --delete $(printf -- "--exclude=%s " "${exclude_folders[@]}") "$empty_dir/" "$target_folder/"
    rmdir "$empty_dir"
    check_ret
}

function clone_repos() {
    clone_repo $libs_systemui_repo
    clone_repo $development_repo
    clone_repo $frameworks_base_repo
    clone_repo $perfetto_repo
    clone_repo $proto_logging_repo
}

function trim_repos() {
    exclude_folders=("${frameworks_base_repo_targets[@]}")
    trim_repo_folder $frameworks_base_repo
    exclude_folders=("${development_repo_targets[@]}")
    trim_repo_folder $development_repo
    exclude_folders=("${libs_systemui_repo_targets[@]}")
    trim_repo_folder $libs_systemui_repo
}

function build() {
    cd "$(repo_path $development_repo)/tools/winscope"
    npm install
    npm run build:prod
}

clone_repos
trim_repos
build