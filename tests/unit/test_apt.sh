#!/usr/bin/env bash

set -euo pipefail

source /opt/ice/lib/core
ice_load_module "apt"

echo -ne "Update 0: "
ice_apt_update 0
echo -ne "Update  : "
ice_apt_update
echo -ne "Upgrade : "
ice_apt_upgrade
echo ""
echo -ne "beep installed?: "
ice_apt_is_installed beep && echo "sim" || echo "não"
echo -ne "Install beep   : "
ice_apt_install beep
echo -ne "beep installed?: "
ice_apt_is_installed beep && echo "sim" || echo "não"
echo -ne "Purge beep     : "
ice_apt_purge beep
echo -ne "Fix            : "
ice_apt_fix
echo -ne "Require beep   : "
ice_apt_require_bin beep
echo -ne "Install file '': "
ice_apt_install_file
echo "Done"
