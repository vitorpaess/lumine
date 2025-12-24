# Guia de Instalação Completo - Todos os Pré-requisitos

Este guia ajuda você a instalar todos os componentes necessários para construir o aplicativo Lumene.

## ✅ Checklist de Instalação

Marque cada item conforme você instala:

- [ ] Node.js instalado e funcionando
- [ ] Rust instalado e funcionando  
- [ ] Visual Studio Build Tools instalado
- [ ] Dependências do projeto instaladas (`npm install`)
- [ ] Ícones adicionados ao projeto

## 📦 Instalação Passo a Passo

### 1️⃣ Instalar Node.js

**Por que precisa**: Para executar npm e o Tauri CLI

1. Acesse: https://nodejs.org/
2. Baixe a versão **LTS** (Long Term Support)
3. Execute o instalador `.msi`
4. **Marque "Add to PATH"** durante a instalação
5. Reinicie o PowerShell

**Verificar**:
```powershell
node --version
npm --version
```

**Problemas?** Veja: `INSTALL-NODEJS.md`

---

### 2️⃣ Instalar Rust

**Por que precisa**: Tauri é construído em Rust

1. Acesse: https://rustup.rs/
2. Baixe `rustup-init.exe` (64-bit)
3. Execute o instalador
4. Pressione **Enter** para instalação padrão
5. Aguarde a instalação (pode levar alguns minutos)
6. Reinicie o PowerShell

**Verificar**:
```powershell
rustc --version
cargo --version
```

**Problemas?** Veja: `INSTALL-RUST.md`

---

### 3️⃣ Instalar Visual Studio Build Tools

**Por que precisa**: Rust no Windows precisa de ferramentas de compilação C++ (linker `link.exe`)

1. Acesse: https://visualstudio.microsoft.com/downloads/
2. Role até "All downloads" → "Tools for Visual Studio"
3. Baixe **"Build Tools for Visual Studio 2022"** (ou 2019)
4. Execute o instalador `vs_buildtools.exe`
5. **Marque**: ✅ **"Desktop development with C++"**
6. Instale (pode levar 10-20 minutos)
7. **Reinicie o PowerShell** (muito importante!)

**Problemas?** Veja: `INSTALL-VISUAL-STUDIO.md`

**Alternativa**: Se você já tem Visual Studio 2019 ou superior instalado, certifique-se de que a carga de trabalho "Desktop development with C++" está instalada.

---

### 4️⃣ Instalar Dependências do Projeto

Após instalar Node.js e Rust:

```powershell
cd C:\Users\eudenes\Lumene
npm install
```

Isso instalará:
- @tauri-apps/cli
- @tauri-apps/api
- vite

---

### 5️⃣ Adicionar Ícones

**Obrigatório antes de construir o aplicativo!**

Veja os guias:
- `ICONS.md` - Instruções gerais
- `generate-icons.md` - Guia detalhado
- `generate-icons.py` - Script Python para gerar ícones

Você precisa de:
- `32x32.png`
- `128x128.png`
- `128x128@2x.png` (256x256)
- `icon.ico` (Windows)
- `icon.icns` (macOS)

Coloque todos em: `src-tauri/icons/`

---

## 🧪 Testar a Instalação

Execute este comando para verificar se tudo está funcionando:

```powershell
# Verificar Node.js
node --version
npm --version

# Verificar Rust
rustc --version
cargo --version

# Testar o projeto
npm run tauri:dev
```

Se `npm run tauri:dev` funcionar, você verá:
- Uma janela do aplicativo abrindo
- O site https://vitorgravity.lovable.app/ carregando

**Nota**: A primeira vez pode levar 10-30 minutos enquanto o Rust compila todas as dependências do Tauri. Seja paciente! ☕

---

## 🚀 Construir o Aplicativo

Depois que tudo estiver funcionando:

```powershell
npm run tauri:build
```

Isso criará:
- **Windows**: `.exe` em `src-tauri/target/release/bundle/nsis/`
- **macOS**: `.dmg` em `src-tauri/target/release/bundle/dmg/` (apenas no macOS)

---

## ❓ Problemas Comuns

### "npm não é reconhecido"
- Node.js não está instalado ou não está no PATH
- Solução: Instale Node.js e reinicie o PowerShell

### "cargo não é reconhecido" ou "failed to get cargo metadata"
- Rust não está instalado ou não está no PATH
- Solução: Instale Rust e reinicie o PowerShell

### Erro de compilação relacionado a C++ ou "link.exe not found"
- Visual Studio Build Tools não está instalado ou não está no PATH
- Solução: 
  1. Instale "Build Tools for Visual Studio" com "Desktop development with C++"
  2. **Reinicie o PowerShell** (muito importante!)
  3. Veja: `INSTALL-VISUAL-STUDIO.md`

### Primeira compilação muito lenta
- Normal! O Rust compila todas as dependências na primeira vez
- Compilações subsequentes serão muito mais rápidas

---

## 📚 Documentação Adicional

- `SETUP.md` - Visão geral do projeto
- `INSTALL-NODEJS.md` - Guia detalhado Node.js
- `INSTALL-RUST.md` - Guia detalhado Rust
- `ICONS.md` - Guia de ícones
- `README.md` - Documentação principal

---

## 🎯 Resumo Rápido

```powershell
# 1. Instalar Node.js (https://nodejs.org/)
# 2. Instalar Rust (https://rustup.rs/)
# 3. Instalar Visual Studio Build Tools
# 4. Reiniciar PowerShell
# 5. Executar:
cd C:\Users\eudenes\Lumene
npm install
npm run tauri:dev
```

Boa sorte! 🚀


