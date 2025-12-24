# Remover Atalho do Desinstalador

## ✅ Solução Aplicada

Atualizei o script de patch para **remover completamente** o atalho do desinstalador quando você instala usando `.exe` (NSIS).

## 🔧 O Que Foi Feito

1. ✅ **Patch melhorado** - Remove criação de atalho do desinstalador
2. ✅ **Configuração atualizada** - Agora inclui NSIS nos targets
3. ✅ **Script atualizado** - Remove atalhos do desinstalador do Desktop e Start Menu

## 🚀 Como Usar

### Para .exe (NSIS) - Com Patch

```powershell
npm run tauri:build:exe
```

OU

```powershell
npm run tauri:build:fixed
```

Este comando:
1. Faz o build normal
2. Aplica o patch que remove o atalho do desinstalador
3. Recompila o instalador com as correções

### Para .msi (WiX) - Sem Patch Necessário

```powershell
npm run tauri:build
```

O MSI **não cria atalho do desinstalador** por padrão, então não precisa de patch.

## ✅ Resultado Esperado

### Com .exe (NSIS) + Patch:
- ✅ **1 atalho** do aplicativo (se você escolher criar)
- ❌ **Sem atalho** do desinstalador no Desktop
- ❌ **Sem atalho** do desinstalador no Start Menu
- ✅ Desinstalador ainda disponível em: Painel de Controle → Programas

### Com .msi (WiX):
- ✅ **1 atalho** no Menu Iniciar
- ❌ **Sem atalhos** no Desktop
- ❌ **Sem atalho** do desinstalador (padrão do MSI)

## 📋 O Que o Patch Faz

O script `patch-installer-fixed.ps1` agora:

1. ✅ Remove o botão "Create Desktop Shortcut" da página de finish
2. ✅ Modifica `CreateDesktopShortcut` para remover atalhos do desinstalador
3. ✅ Remove qualquer criação de atalho do desinstalador no Start Menu
4. ✅ Remove atalhos existentes do desinstalador

## 🎯 Recomendação

**Para melhor resultado:**
- **Use MSI** (`"targets": ["msi"]`) - Não cria atalho do desinstalador por padrão
- **OU use NSIS com patch** (`npm run tauri:build:exe`) - Remove o atalho do desinstalador

## 📝 Nota

O desinstalador ainda estará disponível em:
- **Painel de Controle** → Programas → Desinstalar
- Ou execute: `appwiz.cpl`

Apenas o **atalho visual** foi removido. O desinstalador ainda funciona normalmente!

