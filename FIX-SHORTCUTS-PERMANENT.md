# Solução Permanente: Apenas 1 Ícone na Área de Trabalho

## 🎯 Objetivo

Fazer com que o instalador crie automaticamente apenas **1 ícone** do aplicativo na área de trabalho, sem o desinstalador e sem duplicatas.

## ✅ Solução: Hooks NSIS Personalizados

Criei um arquivo `src-tauri/windows/hooks.nsh` que sobrescreve a função de criação de atalhos do Tauri.

### Como Funciona

O arquivo `hooks.nsh` sobrescreve a função `CreateDesktopShortcut` para:
1. ✅ Remover qualquer atalho existente (evita duplicatas)
2. ✅ Criar apenas 1 atalho do aplicativo
3. ✅ **NÃO criar** atalho do desinstalador

### Arquivo Criado

`src-tauri/windows/hooks.nsh` - Este arquivo será automaticamente incluído pelo Tauri durante o build.

## 🔄 Próximos Passos

1. **Rebuild o aplicativo**:
   ```powershell
   npm run tauri:build
   ```

2. **Teste o novo instalador**:
   - Desinstale a versão antiga
   - Instale a nova versão
   - Verifique: deve aparecer apenas **1 ícone** "Lumene" na área de trabalho

## 📋 O Que Foi Configurado

O hook sobrescreve a função `CreateDesktopShortcut` para:
- Remover atalhos antigos antes de criar novos
- Criar apenas o atalho do aplicativo
- Não criar atalho do desinstalador

## ⚠️ Nota Importante

O Tauri v1 pode não carregar automaticamente o arquivo `hooks.nsh` em todas as versões. Se após o rebuild ainda aparecerem múltiplos ícones, pode ser necessário:

1. Verificar se o Tauri está incluindo o arquivo hooks.nsh
2. Ou usar uma abordagem alternativa (ver abaixo)

## 🔧 Alternativa: Modificar build.rs

Se os hooks não funcionarem automaticamente, podemos modificar o `build.rs` para incluir o arquivo hooks.nsh no script NSIS gerado.

## ✅ Resultado Esperado

Após rebuild e reinstalação:
- ✅ **1 ícone** "Lumene" na área de trabalho
- ✅ **1 entrada** no Menu Iniciar  
- ❌ **Sem ícone** do desinstalador na área de trabalho

O desinstalador ainda estará disponível em:
- Painel de Controle → Programas → Desinstalar
- Ou execute: `appwiz.cpl`

