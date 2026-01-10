#!/usr/bin/env bash

set -euo pipefail

source /opt/ice/lib/core
ice_load_module "disk"

DISCO="/media/public"
echo -ne "Tipo de disco $DISCO: "
ice_disk_get_type "$DISCO" || true
echo -ne "Espaço livre em $DISCO (MB): "
ice_disk_free_mb "$DISCO" || true
