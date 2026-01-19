.PHONY: test lint install

# Corre o ShellCheck em todos os ficheiros .sh
lint:
	shellcheck bin/* lib/*.sh

# Executa os testes unitários com BATS
test:
	bats tests/*.bats

# Simula uma instalação no sistema
install:
	mkdir -p /opt/ice/lib /opt/ice/modules
	cp config/ice.conf /opt/ice/
	cp lib/core /opt/ice/lib
	cp modules/* /opt/ice/modules

all: lint test
