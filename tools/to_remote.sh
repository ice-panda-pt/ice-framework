#!/usr/bin/env bash
set -euo pipefail

ICE_DIR="$HOME"/projects/ice/
REMOTE_DIR=/opt/ice
REMOTE_IP=10.0.0.115
REMOTE_USER=master

main() {

	pushd "$ICE_DIR" >/dev/null

	local op="${1:-}"
	local remote="${REMOTE_USER}@${REMOTE_IP}"
	local pass="na05ediz"

	if [[ "$op" == "up" ]]; then

		if [ ! -f ~/.ssh/id_rsa.pub ]; then
			ssh-keygen -t rsa -f ~/.ssh/id_rsa -N "" -q
		fi
		if ! ssh -o BatchMode=yes -o StrictHostKeyChecking=no "$remote" exit 2>/dev/null; then
			ssh-copy-id -o StrictHostKeyChecking=no "$remote"
		fi

		# shellcheck disable=SC2087
		ssh -t "$remote" <<EOF
echo "$pass" | sudo -S df . -h
if ! command -v rsync >/dev/null 2>&1; then
    sudo -S apt install rsync -y
fi
if [[ ! -d "$REMOTE_DIR" ]]; then
    sudo -S mkdir -p "$REMOTE_DIR"/lib "$REMOTE_DIR"/modules
    sudo -S chown -R "$REMOTE_USER":"$REMOTE_USER" "$REMOTE_DIR"
fi
EOF

		rsync -ah --info=progress2 "$ICE_DIR"/lib/core "$remote":"$REMOTE_DIR"/lib/
		rsync -ah --info=progress2 "$ICE_DIR"/modules/ "$remote":"$REMOTE_DIR"/modules/
		rsync -ah --info=progress2 "$ICE_DIR"/config/ice.conf "$remote":"$REMOTE_DIR"/
	elif [[ "$op" == "down" ]]; then
		# rsync -ah --info=progress2 "$remote":"$REMOTE_DIR"
		true
	else
		echo "Utilização: $(basename "$0") [up|down]"
	fi
	popd >/dev/null
}

main "$@"
