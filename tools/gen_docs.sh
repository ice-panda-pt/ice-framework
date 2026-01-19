#!/usr/bin/env bash
# ICE Framework - Gerador de Docs (shdoc-style simplificado)

DOC_FILE="README.md"

{
	echo "# 🧊 ICE Framework"
	echo "Versão 1.0.0 [69 Funções]"
	echo -e "\n## 🚀 Instalação"
	echo "\`\`\`bash"
	echo "tar -xzf ice-v1.0.0.tar.gz"
	echo "cd ice && sudo ./install.sh"
	echo "\`\`\`"

	echo -e "\n## 📚 Referência de Funções\n"

	for module in modules/*; do
		echo "### 📦 Módulo: $(basename "$module" | tr '[:lower:]' '[:upper:]')"
		echo "| Função | Descrição |"
		echo "| :--- | :--- |"

		# Este awk extrai a linha de comentário (#) imediatamente antes da função
		awk '
            /^# / { last_comment = substr($0, 3) }
            /^[a-zA-Z0-9_]+\(\)/ { 
                gsub(/\(\).*/, "", $1);
                if (last_comment) {
                    print "| `"$1"` | "last_comment" |";
                    last_comment = ""
                }
            }
        ' "$module"
		echo -e "\n"
	done
} >"$DOC_FILE"

echo "Documentação gerada em $DOC_FILE"
