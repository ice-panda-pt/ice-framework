#!/usr/bin/env bash

set -euo pipefail

source /opt/ice/lib/core
ice_load_module "log"

echo "ICE_LOG_FILE=${ICE_LOG_FILE:-}"
echo "run: ice_set_log_file"
ice_set_log_file
echo "ICE_LOG_FILE=${ICE_LOG_FILE:-}"
ice_log_truncate
ice_log "run: ice_log"
ice_info "run: ice_info"
ice_success "run: ice_success"
ice_warn "run: ice_warn"
ice_error "run: ice_error"
#ice_fatal "ice_fatal"
#ice_die "ice_die"
cat "$ICE_LOG_FILE"
