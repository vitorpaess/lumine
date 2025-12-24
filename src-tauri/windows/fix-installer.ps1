# Script para modificar o instalador NSIS gerado
# Este script adiciona o hooks.nsh ao installer.nsi gerado

$installerPath = "target\release\nsis\x64\installer.nsi"
$hooksPath = "windows\hooks.nsh"

if (-not (Test-Path $installerPath)) {
    Write-Host "Installer.nsi not found. Run 'npm run tauri:build' first." -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $hooksPath)) {
    Write-Host "hooks.nsh not found. Skipping." -ForegroundColor Yellow
    exit 0
}

Write-Host "Adding hooks.nsh to installer.nsi..." -ForegroundColor Cyan

# Read the installer.nsi
$content = Get-Content $installerPath -Raw

# Find where to insert the hooks (after the includes, before the defines)
$insertPoint = $content.IndexOf("!define MANUFACTURER")

if ($insertPoint -eq -1) {
    Write-Host "Could not find insertion point in installer.nsi" -ForegroundColor Red
    exit 1
}

# Insert the include statement
$includeLine = "`n!include `"..\..\..\windows\hooks.nsh`"`n"
$newContent = $content.Insert($insertPoint, $includeLine)

# Write back
Set-Content -Path $installerPath -Value $newContent -NoNewline

Write-Host "  OK hooks.nsh included in installer.nsi" -ForegroundColor Green
Write-Host ""
Write-Host "Now rebuild: npm run tauri:build" -ForegroundColor Cyan

