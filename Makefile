.PHONY: test lint install

# Corre o ShellCheck em todos os ficheiros .sh
lint:
	shellcheck bin/* lib/*.sh

# Executa os testes unitários com BATS
test:
	bats tests/*.bats

# Simula uma instalação no sistema
install:
	mkdir -p /usr/local/bin
	cp bin/meu-script /usr/local/bin/
	chmod +x /usr/local/bin/meu-script

all: lint test
