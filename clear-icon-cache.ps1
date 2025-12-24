# Script para limpar cache de icones do Windows
# Execute como Administrador: .\clear-icon-cache.ps1

Write-Host "Limpando cache de icones do Windows..." -ForegroundColor Cyan
Write-Host ""

# Verificar se esta rodando como administrador
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "AVISO: Este script precisa ser executado como Administrador!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Para executar como Administrador:" -ForegroundColor Yellow
    Write-Host "  1. Clique direito no PowerShell" -ForegroundColor White
    Write-Host "  2. Escolha 'Executar como administrador'" -ForegroundColor White
    Write-Host "  3. Execute: .\clear-icon-cache.ps1" -ForegroundColor White
    Write-Host ""
    Write-Host "OU execute manualmente:" -ForegroundColor Yellow
    Write-Host "  taskkill /f /im explorer.exe" -ForegroundColor Cyan
    Write-Host "  Remove-Item `"$env:LOCALAPPDATA\IconCache.db`" -ErrorAction SilentlyContinue" -ForegroundColor Cyan
    Write-Host "  Remove-Item `"$env:LOCALAPPDATA\Microsoft\Windows\Explorer\iconcache*`" -Recurse -Force -ErrorAction SilentlyContinue" -ForegroundColor Cyan
    Write-Host "  Start-Process explorer.exe" -ForegroundColor Cyan
    exit 1
}

Write-Host "Parando o Explorer..." -ForegroundColor Yellow
taskkill /f /im explorer.exe 2>$null

Start-Sleep -Seconds 2

Write-Host "Limpando cache de icones..." -ForegroundColor Yellow

# Limpar cache de icones
$iconCache = "$env:LOCALAPPDATA\IconCache.db"
if (Test-Path $iconCache) {
    Remove-Item $iconCache -Force -ErrorAction SilentlyContinue
    Write-Host "  OK Removido: IconCache.db" -ForegroundColor Green
}

$explorerCache = "$env:LOCALAPPDATA\Microsoft\Windows\Explorer"
if (Test-Path $explorerCache) {
    Get-ChildItem "$explorerCache\iconcache*" -Recurse -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
    Write-Host "  OK Limpo: Cache do Explorer" -ForegroundColor Green
}

Write-Host ""
Write-Host "Reiniciando o Explorer..." -ForegroundColor Yellow
Start-Process explorer.exe

Start-Sleep -Seconds 3

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "Cache de icones limpo com sucesso!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Agora:" -ForegroundColor Cyan
Write-Host "  1. Pressione F5 na area de trabalho para atualizar" -ForegroundColor White
Write-Host "  2. Verifique os icones no Menu Iniciar" -ForegroundColor White
Write-Host "  3. Se necessario, desinstale e reinstale o aplicativo" -ForegroundColor White
Write-Host ""

