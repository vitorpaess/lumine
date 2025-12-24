# Fix: Remover Atalhos Duplicados e Desinstalador

## ✅ Configuração Aplicada

Ajustei o `tauri.conf.json` para:
- ✅ **Não criar atalho do desinstalador** (`createUninstallerShortcut: false`)
- ✅ Criar apenas um atalho na área de trabalho
- ✅ Criar atalho no Menu Iniciar

## 🔄 Próximos Passos

1. **Rebuild o aplicativo**:
   ```powershell
   npm run tauri:build
   ```

2. **Desinstale a versão antiga** completamente

3. **Instale a nova versão**

4. **Verifique**: Agora deve aparecer apenas **1 ícone** do Lumene na área de trabalho

## 📋 O Que Foi Configurado

- `createDesktopShortcut: true` - Cria 1 atalho na área de trabalho
- `createStartMenuShortcut: true` - Cria atalho no Menu Iniciar
- `createUninstallerShortcut: false` - **NÃO cria atalho do desinstalador**

## 🎯 Resultado Esperado

Após rebuild e reinstalação:
- ✅ **1 ícone** "Lumene" na área de trabalho (atalho)
- ✅ **1 entrada** no Menu Iniciar
- ❌ **Sem ícone** do desinstalador na área de trabalho

O desinstalador ainda estará disponível em:
- Painel de Controle → Programas → Desinstalar
- Ou: `appwiz.cpl`

## 💡 Se Ainda Aparecer Duplicado

Se ainda aparecerem 2 ícones do Lumene:

1. **Verifique se não há atalhos antigos** na área de trabalho
2. **Delete manualmente** qualquer atalho duplicado
3. **Crie um novo atalho** arrastando do Menu Iniciar (se necessário)

A configuração está correta - o problema pode ser atalhos antigos que ficaram.

