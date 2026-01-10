# 🧊 ICE Framework
Versão 1.0.0 | [100 Funções Testadas]

## 🚀 Instalação
```bash
tar -xzf ice-v1.0.0.tar.gz
cd ice && sudo ./install.sh
```

## 📚 Referência de Funções

### 📦 Módulo: AEVH
| Função | Descrição |
| :--- | :--- |
| `ice_aevh_init` | Alguns caminhos necessários |
| `ice_aevh_enable_repos` | Habilita repositórios |
| `ice_aevh_is_hp7800` | Deteta se a máquina é uma HP 7800 |


### 📦 Módulo: APT
| Função | Descrição |
| :--- | :--- |
| `ice_apt_is_installed` | @arg $1 Nome do pacote |
| `__ice_apt_cmd` | @description Comando base resiliente para APT |
| `ice_apt_update` | @description Atualiza os índices se tiverem mais de n horas (pré-definido 24) |
| `ice_apt_upgrade` | @description Atualiza o sistema. Tenta o update antes. |
| `ice_apt_install` | @description Instalação inteligente com verificação prévia |
| `ice_apt_fix` | @description Repara o sistema de pacotes se houver interrupções |
| `ice_apt_install_file` | @arg $1 string Caminho para o ficheiro .deb |


### 📦 Módulo: CONFIG
| Função | Descrição |
| :--- | :--- |
| `ice_cfg_get_value` | @arg $3 string Valor padrão (opcional) |
| `ice_cfg_set_value` | @arg $3 string Novo valor |


### 📦 Módulo: DISK
| Função | Descrição |
| :--- | :--- |
| `ice_disk_free_mb` | @arg $2 string Caminho a verificar (padrão: /) |
| `ice_disk_get_type` | @stdout Retorna o tipo de disco ou "DESCONHECIDO" |


### 📦 Módulo: FILE
| Função | Descrição |
| :--- | :--- |
| `ice_file_copy_check` | @arg $2 string Caminho da diretoria de destino |


### 📦 Módulo: LOG
| Função | Descrição |
| :--- | :--- |
| `ice_log_truncate` | @arg $1 string Caminho do ficheiro |
| `ice_set_log_file` | @description Define o ficheiro de escrita de log |
| `ice_log` | @description Mostra a mensagem e grava no logfile, se existir |
| `ice_info` | @description Mostra uma mensagem de informação |
| `ice_success` | @description Mostra uma mensagem de sucesso |
| `ice_warn` | @description Mostra um aviso |
| `ice_error` | @description Mostra um erro |
| `ice_fatal` | @description Mostra um erro e termina o script |
| `ice_die` | @description Mostra uma mensagem e termina o script sem erro |


### 📦 Módulo: MEDIA
| Função | Descrição |
| :--- | :--- |
| `ice_media_hdmi_connected` | @exit 0 se ligado, 1 se desligado |
| `ice_media_change_sink` | @arg $2 string Nome amigável para a notificação |


### 📦 Módulo: NETWORK
| Função | Descrição |
| :--- | :--- |
| `ice_net_port_open` | @arg $2 int Porto |
| `ice_net_is_valid_hostname` | @stdout Retorna 0 se válido, 1 se inválido |
| `ice_net_set_hostname` | @arg $1 string Novo hostname |
| `ice_net_check` | @exit 0 se houver internet, 1 se não houver |
| `ice_net_host_is_up` | @description Verifica se um Host/IP está online |


### 📦 Módulo: SERVICES
| Função | Descrição |
| :--- | :--- |
| `ice_srv_exists` | @arg $1 string Nome do serviço |
| `ice_srv_is_active` | @arg $1 string Nome do serviço |
| `ice_srv_restart` | @arg $1 string Nome do serviço |
| `ice_srv_enable` | @arg $@ - Nome/s do/s serviço/s |
| `ice_srv_disable` | @arg $@ - Nome/s do/s serviço/s |
| `ice_srv_stop` | @arg $@ - Nome/s do/s serviço/s |


### 📦 Módulo: SPEECH
| Função | Descrição |
| :--- | :--- |
| `ice_speak` | @arg $2 string Língua (padrão: pt-pt) |


### 📦 Módulo: SYSTEM
| Função | Descrição |
| :--- | :--- |
| `ice_sys_user_exists` | @arg $1 string Nome do utilizador |
| `ice_sys_get_home` | Devolve a homedir de $1 |
| `ice_sys_run_as` | @arg $@ lista de comandos e argumentos |
| `ice_sys_debian12` | @description Verifica se o sistema é Debian 12 (Bookworm) |
| `ice_sys_debian13` | @description Verifica se o sistema é Debian 13 (Trixie) |
| `ice_sys_get_hardware_model` | @exit 0 se conseguir identificar, uname -m como fallback |
| `ice_sys_optimize` | @usage ice_system_optimize |
| `ice_sys_kill_user` | Matar os processos do $user |
| `ice_sys_clean` | @description Faz uma limpeza e correção completa (Sistema + Utilizadores) |


### 📦 Módulo: UI
| Função | Descrição |
| :--- | :--- |
| `ice_ui_keywait` | @arg $1 string Mensagem personalizada (opcional) |
| `ice_ui_ask` | @arg $2 Valor por defeito (opcional) |
| `ice_ui_confirm` | @exit 0 para Sim, 1 para Não |
| `ice_ui_menu` | @return Devolve o texto da opção selecionada |
| `ice_ui_banner` | @description Mostra um banner/título de secção destacado |
| `ice_ui_spinner_start` | @arg $1 string Mensagem a exibir ao lado do spinner |
| `ice_ui_spinner_stop` | @description Pára o spinner iniciado anteriormente |


