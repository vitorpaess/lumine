# Guia: Criar .dmg para macOS (Apple)

## ✅ Configuração Aplicada

A configuração foi atualizada para gerar tanto:
- ✅ **MSI** para Windows
- ✅ **DMG** para macOS

```json
"bundle": {
  "targets": ["msi", "dmg"]
}
```

## 🍎 Como Criar o .dmg

### ⚠️ Importante: Precisa de um Mac

**Você PRECISA estar em um Mac** para criar o .dmg. Não é possível criar um .dmg no Windows.

### Passos no macOS

1. **Instalar Dependências** (se ainda não tiver):
   ```bash
   # Instalar Xcode Command Line Tools
   xcode-select --install
   
   # Instalar Rust (se não tiver)
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   
   # Instalar Node.js (se não tiver)
   # Baixe de https://nodejs.org/
   ```

2. **Clonar/Copiar o Projeto para o Mac**:
   - Copie toda a pasta do projeto para o Mac
   - Ou use Git para clonar

3. **Instalar Dependências do Projeto**:
   ```bash
   npm install
   ```

4. **Verificar Ícones**:
   - Certifique-se de que `src-tauri/icons/icon.icns` existe
   - Se não tiver, veja `CREATE-ICNS-FOR-MACOS.md`

5. **Build**:
   ```bash
   npm run tauri:build
   ```

6. **Resultado**:
   O arquivo `.dmg` será gerado em:
   ```
   src-tauri/target/release/bundle/dmg/Lumene_1.0.0_x64.dmg
   ```

## 📦 O Que é um .dmg?

- **DMG** (Disk Image) é o formato padrão de distribuição no macOS
- É como um "instalador" para Mac
- Quando o usuário abre o .dmg, vê uma janela com o aplicativo
- O usuário arrasta o app para a pasta Applications

## ✅ Resultado no macOS

Após criar o .dmg e o usuário instalar:
- ✅ Aplicativo na pasta **Applications**
- ✅ Pode ser aberto normalmente
- ✅ Ícone do aplicativo aparece no Launchpad

## 🔄 Opções de Build

### Build Apenas macOS
```json
"targets": ["dmg"]
```

### Build Apenas Windows
```json
"targets": ["msi"]
```

### Build Ambos (Recomendado)
```json
"targets": ["msi", "dmg"]
```

## 🚀 Build Cross-Platform

### Opção 1: Build Manual em Cada Plataforma
- **Windows**: Build no Windows → gera `.msi`
- **macOS**: Build no Mac → gera `.dmg`

### Opção 2: CI/CD (GitHub Actions)
Use GitHub Actions para build automático em ambas as plataformas:
- Workflow para Windows (gera MSI)
- Workflow para macOS (gera DMG)

## 📝 Notas Importantes

1. **Você precisa de um Mac físico ou virtual** para criar o .dmg
2. **Não é possível criar .dmg no Windows** (limitação do macOS)
3. **O ícone .icns é obrigatório** para macOS
4. **Code Signing**: Para distribuição pública, você precisa assinar o app (requer conta Apple Developer)

## 🎯 Próximos Passos

1. Se você tem um Mac: Execute `npm run tauri:build` no Mac
2. Se não tem um Mac: Use GitHub Actions ou peça para alguém com Mac fazer o build
3. Para distribuição pública: Configure code signing (Apple Developer account)

## 🔗 Links Úteis

- [Tauri macOS Guide](https://v1.tauri.app/v1/guides/building/macos)
- [Apple Developer](https://developer.apple.com/) - Para code signing


