#!/usr/bin/env bash
# ==============================================================================
# ICE Framework - Instalador de Estrutura Completa
# ==============================================================================

# Cores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

# Caminhos de Destino (Padronizados)
INSTALL_DIR="/opt/ice"
BIN_LINK="/usr/local/bin/ice"

echo -e "${BLUE}=======================================${NC}"
echo -e "   Instalador ICE Framework v1.0.0"
echo -e "${BLUE}=======================================${NC}"

# Verificar privilégios
if [[ $EUID -ne 0 ]]; then
	echo -e "${BLUE}[INFO]${NC} A tentar obter root..."
	exec sudo "$0" "$@"
fi

# Criar estrutura no sistema
echo -ne "A criar diretórios em $INSTALL_DIR ... "
mkdir -p "$INSTALL_DIR"/{lib,modules}
echo -e "${GREEN}OK${NC}"

# Copiar ficheiros do pacote para o sistema
echo -ne "A instalar ficheiros core e configurações ... "
tar xzf ice.tar.gz
cd ice  || exit 1
cp lib/core "$INSTALL_DIR/lib/"
[[ -f config/ice.conf ]] && cp config/ice.conf "$INSTALL_DIR/" 
[[ -f ice.conf ]] && cp ice.conf "$INSTALL_DIR/"
cp -r modules/* "$INSTALL_DIR/modules/"
echo -e "${GREEN}OK${NC}"

# 4. Instalar Dependências
echo -ne "A validar dependências do sistema ... "
apt-get update -qq && apt-get install -qq -y curl alsa-utils >/dev/null 2>&1
echo -e "${GREEN}OK${NC}"

# 5. Configurar o comando global 'ice'
# Este wrapper permite carregar o framework de qualquer lugar
echo -ne "A configurar atalho global ... "
cat <<EOF >"$BIN_LINK"
#!/usr/bin/env bash
# ICE Framework Loader
export ICE_HOME="$INSTALL_DIR"
source "\$ICE_HOME/lib/core"
EOF
chmod +x "$BIN_LINK"
echo -e "${GREEN}OK${NC}"

# 6. Definir permissões finais
chmod -R 755 "$INSTALL_DIR"

echo -e "${BLUE}=======================================${NC}"
echo -e "${GREEN}INSTALAÇÃO TERMINADA!${NC}"
echo -e "Estrutura: $INSTALL_DIR"
echo -e "Comando: 'ice' (para carregar o core)"
echo -e "${BLUE}=======================================${NC}"
