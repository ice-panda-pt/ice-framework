#!/usr/bin/env bash

set -euo pipefail

source /opt/ice/lib/core

# Chamados pela própria lib ao carregar
# ice_init
# ice_load_config

mod_status() {
	local var_name="$1"
	if [[ -v "$var_name" ]] && [[ "${!var_name}" == "1" ]]; then
		echo "✅"
	else
		echo "❌"
	fi
}

var_value() {
	local var_name="$1"
	if [[ -v "$var_name" ]]; then
		echo "$var_name = '${!var_name}'"
	else
		echo "$var_name = ''"
	fi
}

module_report() {
	echo "Core       : $(mod_status _ICE_CORE_LOADED)"
	echo "APT        : $(mod_status _ICE_APT_LOADED)"
	echo "Config     : $(mod_status _ICE_CONFIG_LOADED)"
	echo "Disk       : $(mod_status _ICE_DISK_LOADED)"
	echo "File       : $(mod_status _ICE_FILE_LOADED)"
	echo "Log        : $(mod_status _ICE_LOG_LOADED)"
	echo "Media      : $(mod_status _ICE_MEDIA_LOADED)"
	echo "Network    : $(mod_status _ICE_NETWORK_LOADED)"
	echo "Services   : $(mod_status _ICE_SERVICES_LOADED)"
	echo "Speech     : $(mod_status _ICE_SPEECH_LOADED)"
	echo "System     : $(mod_status _ICE_SYS_LOADED)"
	echo "UI         : $(mod_status _ICE_UI_LOADED)"
}

echo "EUID: $EUID"
if ! ice_needs_root; then
	echo "Era preciso o root"
fi
echo "A obter root"
ice_getroot
ice_needs_root

echo " === Antes de carregar os módulos"
module_report

ice_load_module "apt"
ice_load_module "config"
ice_load_module "disk"
ice_load_module "file"
ice_load_module "log"
ice_load_module "media"
ice_load_module "network"
ice_load_module "services"
ice_load_module "speech"
ice_load_module "system"
ice_load_module "ui"

echo " === Depois de carregar os módulos"
module_report

var_value ICE_WEBHOOK_URL
var_value ICE_LOG_LEVEL
var_value ICE_DEFAULT_LOG_DIR
var_value ICE_DEBUG
var_value ICE_SPEAK
var_value ICE_SPEAK_WAIT
var_value PIPER_BIN
var_value PIPER_MODEL
