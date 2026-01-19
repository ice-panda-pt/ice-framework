#!/usr/bin/env bash
# ==============================================================================
# ICE Framework - Instalador de Estrutura Completa
# ==============================================================================

set -euo pipefail

# Caminhos de Destino
INSTALL_DIR="/opt/ice"
BIN_LINK="/usr/local/bin/ice"
SRC="ice.tar.gz"
TEMP_DIR=$(mktemp -d)

# Cores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

# Limpeza automática ao sair (sucesso ou erro)
cleanup() {
	rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

fail() {
	echo -e "${RED}[FATAL]${NC} ${1:-}"
	exit 1
}

success() { echo -e "${GREEN}OK${NC}"; }

backup_config() {
	if [[ -f "$INSTALL_DIR/ice.conf" ]]; then
		local backup_name
		backup_name="ice.conf.backup.$(date +%s)"
		echo "Configuração existente detetada. A criar backup em $backup_name"
		cp "$INSTALL_DIR/ice.conf" "$INSTALL_DIR/$backup_name"
	fi
}

main() {
	echo -e "${BLUE}=======================================${NC}"
	echo -e "   Instalador ICE Framework v1.0.0"
	echo -e "${BLUE}=======================================${NC}"
	[[ -f "$SRC" ]] || fail "Ficheiro '$SRC' não encontrado na pasta atual."
	# Dependências
	echo -ne "A validar dependências do sistema ... "
	apt-get update -qq && apt-get install -qq -y curl alsa-utils >/dev/null 2>&1
	command -v "aplay" &>/dev/null || fail "Comando aplay não encontrado"
	command -v "curl" &>/dev/null || fail "Comando curl não encontrado"
	echo -e "${GREEN}OK${NC}"
	# Criar estrutura no sistema
	echo -ne "A criar diretórios em $INSTALL_DIR ... "
	mkdir -p "$INSTALL_DIR"/{lib,modules}
	success
	# Copiar ficheiros do pacote para o sistema
	echo -ne "A instalar ficheiros core e configurações ... "
	tar xzf "$SRC" -C "$TEMP_DIR" || fail "Falha ao descomprimir"
	local extract_path="$TEMP_DIR"
	[[ -d "$TEMP_DIR/ice" ]] && extract_path="$TEMP_DIR/ice"
	cp "$extract_path/lib/core" "$INSTALL_DIR/lib/" || fail "Falha ao copiar core"
	# Instalar Módulos
	if [[ -d "$extract_path/modules" ]]; then
		cp -r "$extract_path/modules/"* "$INSTALL_DIR/modules/" || fail "Falha ao copiar módulos"
	fi
	success
	# Configuração
	backup_config
	[[ -f "$extract_path/config/ice.conf" ]] && cp "$extract_path/config/ice.conf" "$INSTALL_DIR/"
	[[ -f "$extract_path/ice.conf" ]] && cp "$extract_path/ice.conf" "$INSTALL_DIR/"

	# Configurar o comando global 'ice'
	# Este wrapper permite carregar o framework de qualquer lugar
	echo -ne "A configurar atalho global ... "
	cat <<EOF >"$BIN_LINK"
#!/usr/bin/env bash
# ICE Framework Loader
export ICE_HOME="$INSTALL_DIR"

# Carrega o core
if [ -f "\$ICE_HOME/lib/core" ]; then
    source "\$ICE_HOME/lib/core"
else
    echo "Erro: Core ICE não encontrado em \$ICE_HOME"
    exit 1
fi
EOF
	chmod +x "$BIN_LINK"
	echo -e "${GREEN}OK${NC}"

	chmod -R 755 "$INSTALL_DIR"

	echo -e "${BLUE}=======================================${NC}"
	echo -e "${GREEN}INSTALAÇÃO TERMINADA!${NC}"
	echo -e "Estrutura: $INSTALL_DIR"
	echo -e "Comando: 'ice' (para carregar o core)"
	echo -e "${BLUE}=======================================${NC}"
}

if [[ $EUID -ne 0 ]]; then
	echo -e "${BLUE}[INFO]${NC} A tentar obter root..."
	exec sudo "$0" "$@"
fi
main "$@"
