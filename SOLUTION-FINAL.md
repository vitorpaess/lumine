# Solução Final: Tauri v1 Não Suporta `"shortcut": false`

## ❌ Problema

A opção `"shortcut": false` **não existe no Tauri v1**. Essa configuração só está disponível no Tauri v2+.

## ✅ Solução: Usar o Script de Patch

Como o Tauri v1 não suporta desabilitar atalhos via configuração, a única solução é usar o script de patch que modifica o `installer.nsi` gerado.

## 🚀 Como Usar

### Método 1: Build Automático (Recomendado)

```powershell
npm run tauri:build:fixed
```

Este comando:
1. Faz o build normal
2. Aplica o patch no `installer.nsi` gerado
3. Recompila o instalador com as correções

### Método 2: Manual

1. **Build normal**:
   ```powershell
   npm run tauri:build
   ```

2. **Aplicar patch**:
   ```powershell
   cd src-tauri
   powershell -ExecutionPolicy Bypass -File windows/patch-installer-fixed.ps1
   cd ..
   ```

3. **Recompilar**:
   ```powershell
   npm run tauri:build
   ```

## 📋 O Que o Patch Faz

O script `patch-installer-fixed.ps1`:

1. ✅ **Remove o botão** "Create Desktop Shortcut" da página de finish
2. ✅ **Modifica a função** `CreateDesktopShortcut` para:
   - Remover atalhos duplicados antes de criar
   - Remover atalho do desinstalador
   - Criar apenas 1 atalho do aplicativo
3. ✅ **Desabilita chamada automática** que cria atalho em modo silencioso

## ✅ Resultado

Após usar `npm run tauri:build:fixed` e instalar:
- ✅ **1 ícone** "Lumene" na área de trabalho
- ✅ **1 entrada** no Menu Iniciar
- ❌ **Sem ícone** do desinstalador na área de trabalho

## ⚠️ Importante

O patch precisa ser aplicado **após cada build**, porque o Tauri regenera o `installer.nsi` a cada build. Por isso o comando `tauri:build:fixed` faz:
1. Build inicial (gera installer.nsi)
2. Aplica patch
3. Rebuild (compila o instalador corrigido)

## 🔄 Workflow Recomendado

Sempre que fizer build para distribuição:

```powershell
npm run tauri:build:fixed
```

Isso garante que o instalador sempre tenha as correções aplicadas!

## 📝 Nota sobre Tauri v2

Se você atualizar para Tauri v2 no futuro, poderá usar:
```json
"nsis": {
  "shortcut": false
}
```

Mas no Tauri v1, o patch é a única solução que funciona.

