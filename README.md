<div align="center">
  <h1>✨ Disk Duplicator SH ✨</h1>
  <p><strong>Uma ferramenta de linha de comando poderosa e segura para clonagem, backup (imagem) e restauração de discos no Linux.</strong></p>
  <br>
  <p>
    <img src="https://img.shields.io/badge/Licen%C3%A7a-MIT-blue.svg" alt="Licença MIT">
    <img src="https://img.shields.io/badge/Feito%20com-Bash-green.svg" alt="Feito com Bash">
    <img src="https://img.shields.io/badge/Manuten%C3%A7%C3%A3o-Sim-brightgreen.svg" alt="Manutenção Ativa">
  </p>
</div>

<p align="right">
 <a href="#-disk-duplicator-sh-en">English</a> • <a href="#-disk-duplicator-sh-pt-br">Português (BR)</a>
</p>

<a name="-disk-duplicator-sh-pt-br"></a>

---

## 🇧🇷 Versão em Português

### 🚀 Demonstração
![Demonstração do Script](https://i.imgur.com/P2zUhOs.gif)

### 🤔 Por que usar o Disk Duplicator SH?
Ferramentas como o `dd` são extremamente poderosas, mas também perigosas. Um único erro de digitação (`/dev/sda` em vez de `/dev/sdb`) pode resultar na perda total de dados.

Este script atua como uma **camada de segurança e conveniência** sobre o `dd`, com um menu interativo e múltiplas confirmações para garantir que você esteja realizando a operação correta no disco certo.

### ✅ Funcionalidades Principais
-   ✅ **Criação e Restauração de Imagens:** Crie backups completos de seus discos (`.img`) e restaure-os com segurança.
-   ✅ **Clonagem Direta de Disco:** Clone um disco rígido ou SSD diretamente para outro, ideal para migrações de sistema.
-   ✅ **Compressão Eficiente:** Suporte opcional para compressão com `zstd`, um algoritmo moderno e rápido que economiza espaço e tempo.
-   ✅ **Segurança em Primeiro Lugar:** Múltiplas verificações para prevenir erros catastróficos:
    -   Impede a clonagem de um disco para ele mesmo.
    -   Verifica se o disco de destino não é menor que o de origem.
    -   Exige uma confirmação explícita **digitando o nome do disco de destino** antes de apagar qualquer dado.
-   ✅ **Interface Amigável:** Um menu interativo e colorido que guia o usuário em todas as etapas.
-   ✅ **Verificação de Integridade:** Gera e verifica hashes `SHA-256` para garantir que suas imagens de disco não estejam corrompidas.
-   ✅ **Barra de Progresso:** Utiliza o `pv` (Pipe Viewer), se instalado, para exibir uma barra de progresso detalhada.

### 🔧 Instalação e Uso

> **⚠️ ATENÇÃO:** Este script realiza operações de baixo nível em discos. Use com extremo cuidado. Um backup dos seus dados importantes é sempre recomendado antes de qualquer operação de disco. O autor não se responsabiliza por qualquer perda de dados.

#### 1. Pré-requisitos
O script depende de algumas ferramentas comuns no Linux. A maioria já vem instalada.

-   `bash`, `dd`, `lsblk`, `sha256sum`, `blockdev`
-   **Opcional:** `zstd` (para compressão) e `pv` (para barra de progresso).

Para instalar as dependências em sistemas baseados em **Debian/Ubuntu**:
```bash
sudo apt update
sudo apt install -y coreutils util-linux zstd pv

Clone o Repositório

git clone [https://github.com/Yagami-Murakami/disk-duplicator-sh.git](https://github.com/Yagami-Murakami/disk-duplicator-sh.git)
cd disk-duplicator-sh

Execute o Script

O script precisa de permissões de root para acessar os discos diretamente.
sudo ./disk-duplicator.sh


Após a execução, um menu interativo irá guiá-lo pelas opções disponíveis.

🙏 Como Contribuir
Contribuições são muito bem-vindas! Se você tem uma ideia para melhorar o script, encontrou um bug ou quer adicionar uma nova funcionalidade:

Faça um Fork do projeto.

Crie uma nova Branch: git checkout -b feature/sua-feature.

Faça o Commit das suas alterações: git commit -m 'Adiciona sua-feature'.

Faça o Push para a Branch: git push origin feature/sua-feature.

Abra um Pull Request.

📄 Licença
Este projeto está licenciado sob a Licença MIT. Veja o arquivo LICENSE para mais detalhes.


🇬🇧 English Version
🚀 Demonstration
🤔 Why use Disk Duplicator SH?
Tools like dd are extremely powerful, but also dangerous. A single typo (/dev/sda instead of /dev/sdb) can result in total data loss.

This script acts as a safety and convenience layer on top of dd, featuring an interactive menu and multiple confirmations to ensure you are performing the right operation on the right disk.

✅ Key Features
✅ Image Creation & Restoration: Create full backups of your disks (.img) and restore them safely.

✅ Direct Disk Cloning: Clone one hard drive or SSD directly to another, ideal for system migrations.

✅ Efficient Compression: Optional support for zstd compression, a modern and fast algorithm that saves space and time.

✅ Safety First: Multiple checks to prevent catastrophic errors:

Prevents cloning a disk onto itself.

Checks if the destination disk is smaller than the source.

Requires explicit confirmation by typing the destination disk's name before erasing any data.

✅ User-Friendly Interface: An interactive and colorful menu that guides the user through every step.

✅ Integrity Check: Generates and verifies SHA-256 hashes to ensure your disk images are not corrupted.

✅ Progress Bar: Uses pv (Pipe Viewer), if installed, to display a detailed progress bar.

🔧 Installation and Usage
⚠️ WARNING: This script performs low-level disk operations. Use it with extreme caution. Backing up your important data is always recommended before any disk operation. The author is not responsible for any data loss.

Prerequisites
The script relies on a few common Linux tools. Most are pre-installed.

bash, dd, lsblk, sha256sum, blockdev

Optional: zstd (for compression) and pv (for a progress bar).

To install the dependencies on Debian/Ubuntu-based systems:

sudo apt update
sudo apt install -y coreutils util-linux zstd pv

Clone the Repository

git clone [https://github.com/Yagami-Murakami/disk-duplicator-sh.git](https://github.com/Yagami-Murakami/disk-duplicator-sh.git)
cd disk-duplicator-sh

Run the Script

The script requires root privileges to access disks directly.

sudo ./disk-duplicator.sh


Once executed, an interactive menu will guide you through the available options.

🙏 How to Contribute
Contributions are very welcome! If you have an idea to improve the script, found a bug, or want to add a new feature:

Fork the project.

Create a new Branch: git checkout -b feature/your-feature.

Commit your changes: git commit -m 'Adds your-feature'.

Push to the Branch: git push origin feature/your-feature.

Open a Pull Request.

📄 License
This project is licensed under the MIT License. See the LICENSE file for more details


🇬🇧 English Version
🚀 Demonstration
An image or GIF demonstrating the script would go here.

![Script Demonstration](https://i.imgur.com/P2zUhOs.gif)
🤔 Why use Disk Duplicator SH?
Tools like dd are extremely powerful, but also dangerous. A single typo (/dev/sda instead of /dev/sdb) can result in total data loss.

This script acts as a safety and convenience layer on top of dd, featuring an interactive menu and multiple confirmations to ensure you are performing the right operation on the right disk.

✅ Key Features
✅ Image Creation & Restoration: Create full backups of your disks (.img) and restore them safely.

✅ Direct Disk Cloning: Clone one hard drive or SSD directly to another, ideal for system migrations.

✅ Efficient Compression: Optional support for zstd compression, a modern and fast algorithm that saves space and time.

✅ Safety First: Multiple checks to prevent catastrophic errors:

Prevents cloning a disk onto itself.

Checks if the destination disk is not smaller than the source.

Requires explicit confirmation by typing the destination disk's name before erasing any data.

✅ User-Friendly Interface: An interactive and colorful menu that guides the user through every step.

✅ Integrity Check: Generates and verifies SHA-256 hashes to ensure your disk images are not corrupted.

✅ Progress Bar: Uses pv (Pipe Viewer), if installed, to display a detailed progress bar.

🔧 Installation and Usage
⚠️ WARNING: This script performs low-level disk operations. Use it with extreme caution. Backing up your important data is always recommended before any disk operation. The author is not responsible for any data loss.

1. Prerequisites
The script relies on a few common Linux tools, most of which are likely pre-installed: bash, dd, lsblk, sha256sum, and blockdev.

Optional dependencies for extra features are zstd (for compression) and pv (for a progress bar).

To install all dependencies on Debian/Ubuntu-based systems:




