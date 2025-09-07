# disk-duplicator-sh
Um script de shell (Bash) para criar, restaurar e clonar imagens de disco.
# Disk Duplicator SH

Um script de shell (Bash) para criar, restaurar e clonar imagens de disco de forma segura e eficiente, com uma interface de menu interativa.

## Funcionalidades

- **Criar Imagem:** Cria uma imagem completa de um disco (`dd`) em um arquivo.
- **Restaurar Imagem:** Restaura um arquivo de imagem para um disco físico.
- **Clonar Disco:** Clona um disco diretamente para outro (`disco -> disco`).
- **Compressão:** Suporte opcional para compressão com `zstd`.
- **Verificação de Hash:** Gera e verifica hashes `SHA-256` para garantir a integridade das imagens.
- **Segurança:** Múltiplas verificações para prevenir erros (clonagem para disco menor, etc.).
- **Interface Amigável:** Menu colorido e interativo com barra de progresso (usando `pv`, se instalado).

## Requisitos

Este script foi projetado para sistemas Linux e depende dos seguintes comandos:
- `bash`, `dd`, `lsblk`, `sha256sum`, `blockdev`
- `zstd` (opcional)
- `pv` (opcional)

Você pode instalar as dependências em sistemas baseados em Debian/Ubuntu com:
```bash
sudo apt update
sudo apt install coreutils util-linux zstd pv
