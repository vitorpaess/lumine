# Script FIXED para modificar o instalador NSIS gerado
# Este script realmente funciona!

$installerPath = "target\release\nsis\x64\installer.nsi"

if (-not (Test-Path $installerPath)) {
    Write-Host "ERRO: installer.nsi nao encontrado. Execute 'npm run tauri:build' primeiro." -ForegroundColor Red
    exit 1
}

Write-Host "Modificando installer.nsi..." -ForegroundColor Cyan
Write-Host ""

# Ler o arquivo linha por linha
$lines = Get-Content $installerPath
$newLines = @()
$modified = $false
$skipNext = 0

for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]
    
    # 1. Remover botao da pagina de finish
    if ($line -match '!define MUI_FINISHPAGE_SHOWREADME$') {
        Write-Host "  OK Removendo botao da pagina de finish (linha $($i+1))" -ForegroundColor Green
        $skipNext = 2  # Pular as proximas 2 linhas tambem
        $modified = $true
        continue
    }
    
    if ($skipNext -gt 0) {
        $skipNext--
        continue
    }
    
    # 2. Modificar funcao CreateDesktopShortcut
    if ($line -match '^Function CreateDesktopShortcut$') {
        Write-Host "  OK Modificando funcao CreateDesktopShortcut (linha $($i+1))" -ForegroundColor Green
        $newLines += "Function CreateDesktopShortcut"
        $newLines += "  ; Remove any existing shortcuts first to avoid duplicates"
        $newLines += "  Delete `"`$DESKTOP\`${MAINBINARYNAME}.lnk`""
        $newLines += "  Delete `"`$DESKTOP\uninstall.lnk`""
        $newLines += ""
        $newLines += "  ; Create only ONE desktop shortcut for the app"
        $newLines += "  CreateShortcut `"`$DESKTOP\`${MAINBINARYNAME}.lnk`" `"`$INSTDIR\`${MAINBINARYNAME}.exe`""
        $newLines += "  !insertmacro SetLnkAppUserModelId `"`$DESKTOP\`${MAINBINARYNAME}.lnk`""
        $newLines += ""
        $newLines += "  ; Do NOT create uninstaller shortcut on desktop"
        $newLines += "  ; The uninstaller is still available in Control Panel"
        
        # Pular as linhas originais da funcao
        $i++  # Pular linha do CreateShortcut
        $i++  # Pular linha do SetLnkAppUserModelId
        # A linha FunctionEnd sera adicionada quando encontrarmos
        $modified = $true
        continue
    }
    
    # 4. Remover criacao de atalho do desinstalador no Start Menu
    if ($line -match 'CreateShortcut.*uninstall' -or $line -match 'CreateShortcut.*Uninstall') {
        Write-Host "  OK Removendo criacao de atalho do desinstalador (linha $($i+1))" -ForegroundColor Green
        $newLines += "; $line - REMOVIDO: nao criar atalho do desinstalador"
        $modified = $true
        continue
    }
    
    # 5. Remover atalho do desinstalador se ja existir
    if ($line -match 'Delete.*uninstall\.lnk' -or $line -match 'Delete.*Uninstall\.lnk') {
        # Manter a linha de delete (e bom remover se existir)
        $newLines += $line
        continue
    }
    
    # 3. Remover chamada automatica (comentar)
    if ($line -match '^\s+Call CreateDesktopShortcut$' -and $i -gt 580) {
        Write-Host "  OK Desabilitando chamada automatica (linha $($i+1))" -ForegroundColor Green
        $newLines += $line -replace 'Call CreateDesktopShortcut', '; Call CreateDesktopShortcut - REMOVIDO para evitar duplicatas'
        $modified = $true
        continue
    }
    
    # Adicionar linha normalmente
    $newLines += $line
}

if ($modified) {
    Set-Content -Path $installerPath -Value ($newLines -join "`r`n")
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "Modificacoes aplicadas com sucesso!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Agora recompile:" -ForegroundColor Cyan
    Write-Host "  npm run tauri:build" -ForegroundColor White
} else {
    Write-Host "  AVISO: Nenhuma modificacao foi necessaria" -ForegroundColor Yellow
    Write-Host "  O arquivo pode ja estar modificado" -ForegroundColor Yellow
}

