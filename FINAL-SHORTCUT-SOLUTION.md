# Solução Final: Apenas 1 Ícone na Área de Trabalho

## 🎯 Problema

O instalador cria:
- 2 ícones do Lumene (duplicado)
- 1 ícone do desinstalador

## ✅ Solução: Modificar o Script NSIS

Criei um script que modifica o `installer.nsi` gerado pelo Tauri para:
1. ✅ Remover atalhos duplicados antes de criar
2. ✅ Não criar atalho do desinstalador
3. ✅ Criar apenas 1 atalho do aplicativo

## 🔧 Como Usar

### Opção 1: Build Automático (Recomendado)

Execute:
```powershell
npm run tauri:build:fixed
```

Este comando:
1. Faz o build normal
2. Modifica o script NSIS gerado
3. Recompila o instalador com as correções

### Opção 2: Manual

1. **Build normal**:
   ```powershell
   npm run tauri:build
   ```

2. **Aplique o patch**:
   ```powershell
   cd src-tauri
   powershell -ExecutionPolicy Bypass -File windows/patch-installer.ps1
   ```

3. **Recompile o instalador** (se necessário):
   O Tauri geralmente recompila automaticamente, mas se não funcionar:
   ```powershell
   npm run tauri:build
   ```

## 📋 O Que o Script Faz

O script `patch-installer.ps1` modifica a função `CreateDesktopShortcut` no `installer.nsi` para:

```nsis
Function CreateDesktopShortcut
  ; Remove any existing shortcuts first to avoid duplicates
  Delete "$DESKTOP\Lumene.lnk"
  Delete "$DESKTOP\uninstall.lnk"
  
  ; Create only ONE desktop shortcut for the app
  CreateShortcut "$DESKTOP\Lumene.lnk" "$INSTDIR\Lumene.exe"
  
  ; Do NOT create uninstaller shortcut on desktop
FunctionEnd
```

## ✅ Resultado

Após usar esta solução e instalar:
- ✅ **1 ícone** "Lumene" na área de trabalho
- ✅ **1 entrada** no Menu Iniciar
- ❌ **Sem ícone** do desinstalador na área de trabalho

## 🔄 Workflow Recomendado

Sempre que fizer build para distribuição:

```powershell
npm run tauri:build:fixed
```

Isso garante que o instalador sempre crie apenas 1 ícone.

## 📝 Nota

O script modifica o arquivo `installer.nsi` gerado em:
```
src-tauri/target/release/nsis/x64/installer.nsi
```

Este arquivo é gerado a cada build, então o patch precisa ser aplicado após cada build.

## 🎉 Pronto!

Agora quando qualquer usuário instalar seu aplicativo, verá apenas **1 ícone** na área de trabalho!

