#!/bin/bash
set -ex
THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Switching to working directory
if [ ! -z "${workdir}" ] ; then
	echo
	echo "=> Switching to working directory: ${workdir}"
	echo "$ cd ${workdir}"
	cd "${workdir}"
fi

# Go support
go_package_name="github.com/dtrukr/steps-xcode-test"

tmp_gopath_dir="$(mktemp -d)"
full_package_path="${tmp_gopath_dir}/src/${go_package_name}"
mkdir -p "${full_package_path}"

rsync -avh --quiet "${THIS_SCRIPT_DIR}/" "${full_package_path}/"

export GOPATH="${tmp_gopath_dir}"
export GO15VENDOREXPERIMENT=1
go run "${full_package_path}/main.go"