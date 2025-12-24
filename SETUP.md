# Guia de Configuração Completo - Lumene App

## Pré-requisitos Necessários

Para construir o aplicativo desktop, você precisa instalar:

### 1. Node.js (Obrigatório)
- **Download**: https://nodejs.org/
- **Versão**: LTS (v18 ou superior recomendado)
- **Instalação**: Execute o instalador .msi e marque "Add to PATH"

### 2. Rust (Obrigatório)
- **Download**: https://rustup.rs/
- **Instalação**: Execute `rustup-init.exe` e siga as instruções
- **Verificação**: `rustc --version`

### 3. Ferramentas de Build do Windows (Obrigatório)
- **Visual Studio Build Tools** ou **Visual Studio 2019+**
- **Download**: https://visualstudio.microsoft.com/downloads/
- Selecione "Desktop development with C++" durante a instalação

## Passo a Passo de Instalação

### Passo 1: Instalar Node.js
```powershell
# Após instalar, verifique:
node --version
npm --version
```

### Passo 2: Instalar Rust
```powershell
# Após instalar, verifique:
rustc --version
cargo --version
```

### Passo 3: Instalar Dependências do Projeto
```powershell
cd C:\Users\eudenes\Lumene
npm install
```

### Passo 4: Adicionar Ícones (Obrigatório antes de construir)
- Veja `generate-icons.md` ou `ICONS.md` para instruções
- Coloque os arquivos de ícone em `src-tauri/icons/`

### Passo 5: Testar em Desenvolvimento
```powershell
npm run tauri:dev
```

### Passo 6: Construir para Distribuição
```powershell
npm run tauri:build
```

## Estrutura de Arquivos de Ícone Necessários

Coloque estes arquivos em `src-tauri/icons/`:

```
src-tauri/icons/
├── 32x32.png          (32x32 pixels)
├── 128x128.png        (128x128 pixels)
├── 128x128@2x.png     (256x256 pixels)
├── icon.ico           (Windows)
└── icon.icns          (macOS)
```

## Comandos Úteis

```powershell
# Desenvolvimento
npm run tauri:dev

# Construir aplicativo
npm run tauri:build

# Verificar instalações
node --version
npm --version
rustc --version
```

## Onde Encontrar os Arquivos Construídos

Após `npm run tauri:build`:

- **Windows (.exe)**: `src-tauri/target/release/bundle/nsis/Lumene_1.0.0_x64-setup.exe`
- **macOS (.dmg)**: `src-tauri/target/release/bundle/dmg/Lumene_1.0.0_x64.dmg` (apenas no macOS)

## Ajuda Adicional

- Problemas com Node.js: Veja `INSTALL-NODEJS.md`
- Problemas com Rust: Veja `INSTALL-RUST.md`
- Problemas com Visual Studio Build Tools: Veja `INSTALL-VISUAL-STUDIO.md`
- Problemas com ícones: Veja `ICONS.md` ou `generate-icons.md`
- Documentação Tauri: https://tauri.app/


