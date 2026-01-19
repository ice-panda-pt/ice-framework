#!/usr/bin/env bash
# ==============================================================================
# ICE Framework - Script de Empacotamento (Estrutura Completa)
# ==============================================================================

VERSION="1.0.0"
PACKAGE_NAME="ice.tar.gz"
BUILD_DIR="dist_build"
SFX_NAME="ice-v$VERSION.run"

BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${BLUE}=======================================${NC}"
echo -e "  Gerando Pacote de Distribuição v$VERSION"
echo -e "${BLUE}=======================================${NC}"

# Limpeza de builds anteriores
[ -d "$BUILD_DIR" ] && rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR/ice"

# Copiar a estrutura Vital do Framework
echo -ne "A copiar estrutura (lib, config, modules) ... "
cp -r lib/ "$BUILD_DIR/ice/"            # Contém o core da biblioteca
cp -r config/ice.conf "$BUILD_DIR/ice/" # Configuração
cp -r modules/ "$BUILD_DIR/ice/"        # Contém os módulos funcionais

# Copiamos o instalador e o README
cp install.sh "$BUILD_DIR/ice/"
bash ./tools/gen_docs.sh
[ -f "README.md" ] && cp README.md "$BUILD_DIR/ice/"
echo -e "${GREEN}OK${NC}"

# Limpeza de ficheiros não desejados
echo -ne "A limpar ficheiros temporários e de utilizador ... "
rm -f "$BUILD_DIR/ice/.ice.conf"
find "$BUILD_DIR" -name "*.log" -type f -delete
find "$BUILD_DIR" -name ".git*" -delete
find "$BUILD_DIR" -name "*~" -delete
echo -e "${GREEN}OK${NC}"

# Criar o arquivo Comprimido
echo -ne "A gerar $PACKAGE_NAME ... "
cd "$BUILD_DIR" || exit
mkdir ice_install
tar -czf ice_install/"$PACKAGE_NAME" ice/
cp ../install.sh ice_install
makeself --xz ./ice_install ../"$SFX_NAME" "ICE Framework v$VERSION" ./install.sh

cd ..
echo -e "${GREEN}OK${NC}"

# Limpeza final
rm -rf "$BUILD_DIR"

echo -e "${BLUE}=======================================${NC}"
echo -e "${GREEN}Pacote criado com sucesso${NC}"
echo -e "Local: ./$SFX_NAME"
echo -e "${BLUE}=======================================${NC}"
