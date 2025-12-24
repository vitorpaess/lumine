# Remover Atalhos Duplicados e Desinstalador

## 🎯 Solução Rápida (Após Instalação)

Após instalar o aplicativo, você verá 3 ícones na área de trabalho:
1. Lumene (aplicativo principal)
2. Lumene (atalho - com setinha)
3. uninstall (desinstalador)

### Para Limpar:

1. **Delete o atalho do desinstalador**:
   - Clique direito no ícone "uninstall"
   - Escolha "Excluir"

2. **Mantenha apenas 1 ícone do Lumene**:
   - Se houver 2 ícones do Lumene, delete um deles
   - Mantenha apenas o atalho (aquele com a setinha azul)

## 🔧 Solução Permanente (Opcional)

Se você quiser que isso seja automático em futuras instalações, você pode:

### Opção 1: Deletar Manualmente Após Cada Instalação
- Simples e rápido
- Leva 5 segundos

### Opção 2: Usar Script de Limpeza (Avançado)

Crie um arquivo `cleanup-shortcuts.ps1`:

```powershell
# Remover atalho do desinstalador
$uninstallShortcut = "$env:USERPROFILE\Desktop\uninstall.lnk"
if (Test-Path $uninstallShortcut) {
    Remove-Item $uninstallShortcut -Force
    Write-Host "Atalho do desinstalador removido" -ForegroundColor Green
}

# Verificar e remover atalhos duplicados do Lumene
$desktop = "$env:USERPROFILE\Desktop"
$lumeneShortcuts = Get-ChildItem "$desktop\Lumene*.lnk"

if ($lumeneShortcuts.Count -gt 1) {
    # Manter apenas o primeiro, deletar os outros
    $lumeneShortcuts | Select-Object -Skip 1 | Remove-Item -Force
    Write-Host "Atalhos duplicados removidos" -ForegroundColor Green
}
```

Execute após instalar:
```powershell
.\cleanup-shortcuts.ps1
```

## 📝 Nota

O Tauri v1 tem limitações na configuração de atalhos do NSIS. A forma mais simples é deletar manualmente os atalhos extras após a instalação.

O desinstalador ainda estará disponível em:
- **Painel de Controle** → Programas → Desinstalar
- Ou execute: `appwiz.cpl`

## ✅ Resultado Esperado

Após limpar:
- ✅ **1 ícone** "Lumene" na área de trabalho
- ✅ **1 entrada** no Menu Iniciar
- ❌ **Sem ícone** do desinstalador na área de trabalho

