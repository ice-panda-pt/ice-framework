#!/usr/bin/env bash

set -euo pipefail

# shellcheck source=/dev/null
source /opt/ice/lib/core
ice_load_module "ui"

ice_ui_box ICE UI
ice_ui_banner Windoze spin off
ice_ui_keywait
ice_ui_header
ret=$(ice_ui_ask "É de noite?" "sim")
echo "Resposta: $ret"
ice_ui_spinner_start
sleep 1
ice_ui_spinner_stop
ice_ui_confirm "É mesmo de noite?" && echo "Que escuro" || echo "Ah, afinal há Sol"
ice_ui_header "Escolhe o planeta"
if ret=$(ice_ui_menu Mercúrio Vénus Terra Marte Júpiter Saturno Úrano Neptuno); then
	echo "Resposta selecionada: $ret"
else
	echo "Cancelado"
fi
