#!/usr/bin/env bash

set -euo pipefail

source /opt/ice/lib/core
ice_load_module "network"

t_host="8.8.8.8"
t_port="53"

if ice_net_port_open "$t_host" "$t_port"; then
	echo "$t_host:$t_port is open"
else
	echo "$t_host:$t_port is closed"
fi
if ice_net_is_valid_hostname "windoze.pt"; then
	echo "Valid hostname"
else
	echo "This hostname is bogus"
fi
if ice_net_check; then
	echo "Há internet!"
else
	echo "Não há internet :("
fi
if ice_net_host_is_up "$t_host"; then
	echo "Host $t_host is up"
else
	echo "Host $t_host is down :("
fi
