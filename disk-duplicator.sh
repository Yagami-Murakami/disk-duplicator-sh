#!/usr/bin/env bash
#
# Disk Duplicator - Ferramenta aprimorada para criação, restauração e clonagem de discos.
#
# MELHORIAS:
# - Funcionalidade: Adicionada clonagem direta de disco para disco.
# - Segurança: Verificações para impedir clonagem para disco menor ou para o mesmo disco.
# - Performance: Aumentado o block size (bs) do dd para 4M para transferências mais rápidas.
# - UX: Adicionado cores e cabeçalho ASCII para melhor legibilidade e alertas.
# - UX: Uso do 'pv' (Pipe Viewer) se instalado para uma barra de progresso mais precisa.
# - Robustez: Validação de entrada mais rígida e loops para novas tentativas em vez de sair.
# - Legibilidade: Código refatorado para evitar repetição (princípio DRY).
# - Correção: A função list_disks agora imprime em stderr para não interferir com a captura de valores.

set -euo pipefail

# --- Configuração de Cores ---
if command -v tput >/dev/null 2>&1 && [[ -t 1 ]]; then
    COLOR_RESET=$(tput sgr0); COLOR_RED=$(tput setaf 1); COLOR_GREEN=$(tput setaf 2)
    COLOR_YELLOW=$(tput setaf 3); COLOR_BLUE=$(tput setaf 4)
else
    COLOR_RESET="\033[0m"; COLOR_RED="\033[0;31m"; COLOR_GREEN="\033[0;32m"
    COLOR_YELLOW="\033[0;33m"; COLOR_BLUE="\033[0;34m"
fi

# --- Funções de Logging com Cores ---
echo_info() { echo -e "${COLOR_BLUE}==> ${1}${COLOR_RESET}"; }
echo_success() { echo -e "${COLOR_GREEN}✔ ${1}${COLOR_RESET}"; }
echo_warn() { echo -e "${COLOR_YELLOW}‼ ${1}${COLOR_RESET}"; }
echo_error() { echo -e "${COLOR_RED}✖ ${1}${COLOR_RESET}" >&2; }

# --- Funções Utilitárias ---
require_root() {
  if [[ $EUID -ne 0 ]]; then
    echo_error "Este script precisa ser executado como root."; exit 1
  fi
}

need_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo_error "Comando obrigatório não encontrado: $1"; exit 1
  fi
}

pause() {
  echo; read -rp "Pressione [Enter] para continuar..."
}

# --- Lógica Principal ---
list_disks() {
  # CORREÇÃO: Adicionado ">&2" ao final de cada linha que imprime na tela.
  # Isso redireciona a saída informativa para o "standard error", liberando o
  # "standard output" para que a função pick_disk possa retornar apenas o nome do disco.
  echo_info "Dispositivos de bloco detectados:" >&2
  lsblk -dpno NAME,SIZE,MODEL,TYPE,FSTYPE,MOUNTPOINT | sed 's/^/  /' >&2
  echo >&2
}

pick_disk() {
  local prompt="$1"; local disk
  list_disks
  while true; do
    read -rp "$prompt (ex: /dev/sda): " disk
    if [[ -b "$disk" ]]; then echo "$disk"; return 0;
    else echo_error "Dispositivo inválido ou não encontrado. Tente novamente."; fi
  done
}

confirm_destruction() {
  local target="$1"
  echo_warn "ATENÇÃO: TODOS OS DADOS NO DISCO ${target} SERÃO PERMANENTEMENTE APAGADOS!"
  read -rp "Para confirmar esta ação, digite o nome do dispositivo (${target}): " ans
  if [[ "$ans" != "$target" ]]; then
      echo_error "A confirmação falhou. Operação cancelada."; exit 1
  fi
}

create_image() {
  local source_disk image_dir compress_opt image_path final_cmd
  source_disk="$(pick_disk 'Selecione o disco de ORIGEM para criar a imagem')"
  
  read -rp "Diretório de destino da imagem [./disk_images]: " image_dir
  image_dir="${image_dir:-./disk_images}"
  mkdir -p "$image_dir"

  local timestamp; timestamp=$(date +"%Y%m%d-%H%M%S")
  image_path="$image_dir/$(basename "$source_disk")-${timestamp}.img"

  read -rp "Compactar imagem com Zstandard (zstd)? [S/n]: " compress_opt
  
  local dd_cmd="dd if=${source_disk} bs=4M conv=sync,noerror status=progress iflag=fullblock"
  
  if [[ "${compress_opt:-S}" =~ ^[sS]$ ]]; then
    need_cmd zstd; image_path+=".zst"
    echo_info "Criando imagem compactada: $image_path"
    final_cmd="$dd_cmd | zstd -1 -T0 > '${image_path}'"
  else
    echo_info "Criando imagem: $image_path"
    final_cmd="$dd_cmd of='${image_path}'"
  fi
  
  eval "$final_cmd"
  sync
  echo_info "Calculando hash SHA-256 da imagem..."
  sha256sum "$image_path" | tee "$image_path.sha256"
  echo_success "Criação da imagem concluída!"
}

restore_image() {
  local image_file dest_disk
  read -rp "Caminho do arquivo de imagem (.img, .img.zst, .img.gz): " image_file
  [[ -f "$image_file" ]] || { echo_error "Arquivo de imagem não encontrado."; return 1; }
  
  dest_disk="$(pick_disk 'Selecione o disco de DESTINO para restaurar a imagem')"
  confirm_destruction "$dest_disk"
  
  echo_info "Restaurando de '$image_file' para '$dest_disk'..."
  
  local source_cmd
  case "$image_file" in
    *.zst) need_cmd zstd; source_cmd="zstd -dc '${image_file}'" ;;
    *.gz)  need_cmd gzip; source_cmd="gzip -dc '${image_file}'" ;;
    *)     source_cmd="cat '${image_file}'" ;;
  esac
  
  if command -v pv >/dev/null; then source_cmd+=" | pv"; fi
  
  local final_cmd="${source_cmd} | dd of=${dest_disk} bs=4M status=progress oflag=direct"
  eval "$final_cmd"
  sync
  echo_success "Restauração concluída."
}

clone_disk() {
  local source_disk dest_disk
  source_disk="$(pick_disk 'Selecione o disco de ORIGEM da clonagem')"
  dest_disk="$(pick_disk 'Selecione o disco de DESTINO (será APAGADO)')"

  # --- Verificações de Segurança ---
  if [[ "$source_disk" == "$dest_disk" ]]; then
    echo_error "O disco de origem e destino não podem ser o mesmo. Operação cancelada."
    return 1
  fi
  
  local source_size dest_size
  source_size=$(blockdev --getsize64 "$source_disk")
  dest_size=$(blockdev --getsize64 "$dest_disk")

  if (( source_size > dest_size )); then
    echo_error "O disco de destino é MENOR que o disco de origem."
    echo_warn "Origem: ${source_size} bytes | Destino: ${dest_size} bytes."
    echo_warn "Operação cancelada para evitar corrompimento de dados."
    return 1
  fi
  # --- Fim das Verificações ---

  confirm_destruction "$dest_disk"
  
  echo_info "Iniciando a clonagem de '$source_disk' para '$dest_disk'..."
  echo_warn "Esta operação pode levar muito tempo. Por favor, aguarde."

  local clone_cmd
  if command -v pv >/dev/null; then
    # Pipeline com dd | pv | dd para máxima robustez e melhor barra de progresso
    clone_cmd="dd if=${source_disk} bs=4M conv=sync,noerror,sparse | pv -s ${source_size} | dd of=${dest_disk} bs=4M oflag=direct"
  else
    # Fallback para dd simples se pv não estiver instalado
    clone_cmd="dd if=${source_disk} of=${dest_disk} bs=4M conv=sync,noerror,sparse status=progress oflag=direct"
  fi

  eval "$clone_cmd"
  sync
  echo_success "Clonagem concluída com sucesso!"
}

verify_hash() {
  local sumfile
  read -rp "Caminho do arquivo .sha256 para verificação: " sumfile
  [[ -f "$sumfile" ]] || { echo_error "Arquivo de hash não encontrado."; return 1; }
  
  echo_info "Verificando integridade da imagem..."
  (cd "$(dirname "$sumfile")" && sha256sum -c "$(basename "$sumfile")")
}

main_menu() {
  require_root
  need_cmd dd; need_cmd lsblk; need_cmd sha256sum; need_cmd blockdev
  
  while true; do
    clear
    echo -e "${COLOR_BLUE}"
    cat << "EOF"
  ____  ____     ____                    _     _      
|  _ \|  _ \   / ___|___  _ __  _   _  | | __(_)_ __ 
| | | | | | | | |   / _ \| '_ \| | | | | |/ /| | '__|
| |_| | |_| | | |__| (_) | |_) | |_| | |   < | | |   
|____/|____/   \____\___/| .__/ \__, | |_|\_\/ |_|   
                         |_|    |___/      |__/      
EOF
    echo -e "${COLOR_RESET}"
    
    echo "================================================="
    echo " 1) Criar imagem de um disco"
    echo " 2) Restaurar imagem para um disco"
    echo " 3) Clonar um disco para outro (direto)"
    echo " 4) Verificar integridade de uma imagem (.sha256)"
    echo " 5) Listar discos"
    echo " 6) Sair"
    echo "-------------------------------------------------"
    read -rp "Escolha uma opção: " op
    
    case "$op" in
      1) create_image; pause ;;
      2) restore_image; pause ;;
      3) clone_disk; pause ;;
      4) verify_hash; pause ;;
      5) list_disks; pause ;;
      6) exit 0 ;;
      *) echo_error "Opção inválida."; pause ;;
    esac
  done
}

main_menu
