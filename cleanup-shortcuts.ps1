# Script para remover atalhos extras apos instalacao
# Execute: .\cleanup-shortcuts.ps1

Write-Host "Limpando atalhos extras..." -ForegroundColor Cyan
Write-Host ""

$desktop = "$env:USERPROFILE\Desktop"
$removed = $false

# Remover atalho do desinstalador
$uninstallShortcut = "$desktop\uninstall.lnk"
if (Test-Path $uninstallShortcut) {
    Remove-Item $uninstallShortcut -Force
    Write-Host "  OK Removido: uninstall.lnk" -ForegroundColor Green
    $removed = $true
}

# Verificar atalhos do Lumene
$lumeneShortcuts = Get-ChildItem "$desktop\Lumene*.lnk" -ErrorAction SilentlyContinue

if ($lumeneShortcuts) {
    if ($lumeneShortcuts.Count -gt 1) {
        # Manter apenas o primeiro (atalho), deletar os outros
        $toRemove = $lumeneShortcuts | Select-Object -Skip 1
        foreach ($shortcut in $toRemove) {
            Remove-Item $shortcut.FullName -Force
            Write-Host "  OK Removido: $($shortcut.Name)" -ForegroundColor Green
            $removed = $true
        }
    }
}

if (-not $removed) {
    Write-Host "  Nenhum atalho extra encontrado" -ForegroundColor Yellow
} else {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "Limpeza concluida!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
}

Write-Host ""
Write-Host "Agora voce deve ter apenas 1 icone do Lumene na area de trabalho." -ForegroundColor Cyan

