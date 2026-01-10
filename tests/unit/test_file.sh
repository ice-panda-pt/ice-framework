#!/usr/bin/env bash

set -euo pipefail

source /opt/ice/lib/core
ice_load_module "file"

name_f="testing.txt"
name_d="testing_dir"
touch "$name_f"
ice_file_copy_check "$name_f" "$name_d"
ls -1 .
echo ""
ls -1 "$name_d"
rm "$name_d"/"$name_f"
rmdir "$name_d"
rm "$name_f"
