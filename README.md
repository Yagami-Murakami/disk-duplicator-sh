# ✨ Disk Duplicator SH

![Licença MIT](https://img.shields.io/badge/Licen%C3%A7a-MIT-blue.svg)
![Feito com Bash](https://img.shields.io/badge/Feito%20com-Bash-green.svg)
![Manutenção](https://img.shields.io/badge/Manuten%C3%A7%C3%A3o-Sim-brightgreen.svg)

Uma ferramenta de linha de comando poderosa e segura para clonagem, backup (imagem) e restauração de discos no Linux.

---

## 🚀 Demonstração



![Demonstração do Script]([https://i.imgur.com/your-image-url.gif](https://i.imgur.com/P2zUhOs.gif)) 

---

## ✅ Funcionalidades Principais

-   ✅ **Criação e Restauração de Imagens:** Crie backups completos de seus discos e restaure-os com segurança.
-   ✅ **Clonagem Direta de Disco:** Clone um disco rígido ou SSD diretamente para outro, ideal para migrações de sistema.
-   ✅ **Compressão Eficiente:** Suporte opcional para compressão com `zstd`, um algoritmo moderno e rápido que economiza espaço.
-   ✅ **Segurança em Primeiro Lugar:** Múltiplas verificações de segurança para prevenir erros catastróficos:
    -   Impede a clonagem de um disco para ele mesmo.
    -   Verifica se o disco de destino não é menor que o de origem.
    -   Exige uma confirmação explícita antes de apagar qualquer dado.
-   ✅ **Interface Amigável:** Um menu interativo e colorido que guia o usuário em todas as etapas.
-   ✅ **Verificação de Integridade:** Gera e verifica hashes `SHA-256` para garantir que suas imagens de disco não estejam corrompidas.
-   ✅ **Barra de Progresso:** Utiliza o `pv` (Pipe Viewer), se instalado, para exibir uma barra de progresso detalhada durante as operações.

---

## 🔧 Requisitos

Este script foi projetado para sistemas Linux e depende dos seguintes comandos:

-   `bash`
-   `dd`
-   `lsblk`
-   `sha256sum`
-   `blockdev`
-   `zstd` (opcional, para compressão)
-   `pv` (opcional, para uma melhor barra de progresso)

Você pode instalar as dependências em sistemas baseados em Debian/Ubuntu com:
```bash
sudo apt update
sudo apt install coreutils util-linux zstd pv

Com certeza! Um bom README faz toda a diferença para um projeto no GitHub. Ele é a porta de entrada e a primeira impressão que as pessoas terão do seu trabalho.

Analisando seu perfil (Yagami-Murakami), preparei uma versão aprimorada e mais visual do README.md para o seu projeto disk-duplicator-sh. Ele usa elementos de formatação do Markdown para ficar mais organizado e atraente.

Como Atualizar seu README.md
Vá para a página do seu repositório no GitHub.

Clique no arquivo README.md.

Clique no ícone de lápis (✏️) no canto superior direito para editar o arquivo.

Apague todo o conteúdo antigo e cole o código Markdown abaixo.

Role para baixo e clique no botão verde "Commit changes".

✨ Copie e Cole este Código no seu README.md ✨
Markdown

# ✨ Disk Duplicator SH

![Licença MIT](https://img.shields.io/badge/Licen%C3%A7a-MIT-blue.svg)
![Feito com Bash](https://img.shields.io/badge/Feito%20com-Bash-green.svg)
![Manutenção](https://img.shields.io/badge/Manuten%C3%A7%C3%A3o-Sim-brightgreen.svg)

Uma ferramenta de linha de comando poderosa e segura para clonagem, backup (imagem) e restauração de discos no Linux.

---

## 🚀 Demonstração

*(Dica: Grave um GIF rápido do script em ação usando um programa como o [Peek](https://github.com/phw/peek) e coloque aqui para impressionar!)*

![Demonstração do Script](https://i.imgur.com/your-image-url.gif) 

---

## ✅ Funcionalidades Principais

-   ✅ **Criação e Restauração de Imagens:** Crie backups completos de seus discos e restaure-os com segurança.
-   ✅ **Clonagem Direta de Disco:** Clone um disco rígido ou SSD diretamente para outro, ideal para migrações de sistema.
-   ✅ **Compressão Eficiente:** Suporte opcional para compressão com `zstd`, um algoritmo moderno e rápido que economiza espaço.
-   ✅ **Segurança em Primeiro Lugar:** Múltiplas verificações de segurança para prevenir erros catastróficos:
    -   Impede a clonagem de um disco para ele mesmo.
    -   Verifica se o disco de destino não é menor que o de origem.
    -   Exige uma confirmação explícita antes de apagar qualquer dado.
-   ✅ **Interface Amigável:** Um menu interativo e colorido que guia o usuário em todas as etapas.
-   ✅ **Verificação de Integridade:** Gera e verifica hashes `SHA-256` para garantir que suas imagens de disco não estejam corrompidas.
-   ✅ **Barra de Progresso:** Utiliza o `pv` (Pipe Viewer), se instalado, para exibir uma barra de progresso detalhada durante as operações.

---

## 🔧 Requisitos

Este script foi projetado para sistemas Linux e depende dos seguintes comandos:

-   `bash`
-   `dd`
-   `lsblk`
-   `sha256sum`
-   `blockdev`
-   `zstd` (opcional, para compressão)
-   `pv` (opcional, para uma melhor barra de progresso)

Você pode instalar as dependências em sistemas baseados em Debian/Ubuntu com:
```bash
sudo apt update
sudo apt install coreutils util-linux zstd pv
💻 Instalação e Uso
Clone este repositório:

Bash

git clone [https://github.com/Yagami-Murakami/disk-duplicator-sh.git](https://github.com/Yagami-Murakami/disk-duplicator-sh.git)
cd disk-duplicator-sh
Torne o script executável:

Bash

chmod +x disk-duplicator.sh
Execute com privilégios de root:
O script precisa de acesso de root para ler e escrever diretamente nos dispositivos de disco.

Bash

sudo ./disk-duplicator.sh
🙏 Como Contribuir
Contribuições são sempre bem-vindas! Se você tem uma ideia para melhorar o script, encontrou um bug ou quer adicionar uma nova funcionalidade, sinta-se à vontade para:

Fazer um Fork do projeto.

Criar uma nova Branch (git checkout -b feature/sua-feature).

Fazer o Commit das suas alterações (git commit -m 'Adiciona sua-feature').

Fazer o Push para a Branch (git push origin feature/sua-feature).

Abrir um Pull Request.

📄 Licença
Este projeto está licenciado sob a Licença MIT. Veja o arquivo LICENSE para mais detalhes.

<p align="center">
Feito com ❤️ por <a href="https://github.com/Yagami-Murakami">Yagami Murakami</a>
</p>
