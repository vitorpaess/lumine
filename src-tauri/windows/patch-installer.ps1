# Script para modificar o instalador NSIS gerado
# Substitui a funcao CreateDesktopShortcut e remove botao da pagina de finish

$installerPath = "target\release\nsis\x64\installer.nsi"

if (-not (Test-Path $installerPath)) {
    Write-Host "ERRO: installer.nsi nao encontrado. Execute 'npm run tauri:build' primeiro." -ForegroundColor Red
    exit 1
}

Write-Host "Modificando installer.nsi para corrigir atalhos..." -ForegroundColor Cyan

# Ler o arquivo
$content = Get-Content $installerPath -Raw
$modified = $false

# 1. Remover o botao "Create Desktop Shortcut" da pagina de finish
if ($content -match '!define MUI_FINISHPAGE_SHOWREADME') {
    # Remove as 3 linhas relacionadas ao botao
    $content = $content -replace '!define MUI_FINISHPAGE_SHOWREADME\s*\r?\n!define MUI_FINISHPAGE_SHOWREADME_TEXT.*?\r?\n!define MUI_FINISHPAGE_SHOWREADME_FUNCTION CreateDesktopShortcut\s*\r?\n', ''
    Write-Host "  OK Botao 'Create Desktop Shortcut' removido da pagina de finish" -ForegroundColor Green
    $modified = $true
}

# 2. Remover chamada automatica de CreateDesktopShortcut (linha 588)
if ($content -match 'Call CreateDesktopShortcut') {
    # Remover apenas a chamada na secao de instalacao (modo silencioso)
    # Mas manter se for chamada condicional
    $content = $content -replace '(\s+)Call CreateDesktopShortcut\s*\r?\n(\s+)Call CreateStartMenuShortcut', '$1; Call CreateDesktopShortcut - REMOVIDO para evitar duplicatas`r`n$2Call CreateStartMenuShortcut'
    Write-Host "  OK Chamada automatica de CreateDesktopShortcut desabilitada" -ForegroundColor Green
    $modified = $true
}

# 2. Substituir a funcao CreateDesktopShortcut
$oldFunction = "Function CreateDesktopShortcut`r?`n  CreateShortcut `"`$DESKTOP\`${MAINBINARYNAME}.lnk`" `"`$INSTDIR\`${MAINBINARYNAME}.exe`"`r?`n  !insertmacro SetLnkAppUserModelId `"`$DESKTOP\`${MAINBINARYNAME}.lnk`"`r?`nFunctionEnd"

$newFunction = @"
Function CreateDesktopShortcut
  ; Remove any existing shortcuts first to avoid duplicates
  Delete "`$DESKTOP\`${MAINBINARYNAME}.lnk"
  Delete "`$DESKTOP\uninstall.lnk"
  
  ; Create only ONE desktop shortcut for the app
  CreateShortcut "`$DESKTOP\`${MAINBINARYNAME}.lnk" "`$INSTDIR\`${MAINBINARYNAME}.exe"
  !insertmacro SetLnkAppUserModelId "`$DESKTOP\`${MAINBINARYNAME}.lnk"
  
  ; Do NOT create uninstaller shortcut on desktop
  ; The uninstaller is still available in Control Panel
FunctionEnd
"@

if ($content -match [regex]::Escape($oldFunction.Replace("`r`n", "`n"))) {
    $content = $content -replace [regex]::Escape($oldFunction.Replace("`r`n", "`n")), $newFunction
    Write-Host "  OK Funcao CreateDesktopShortcut modificada" -ForegroundColor Green
    $modified = $true
} else {
    # Tentar metodo alternativo - substituir linha por linha
    Write-Host "  Tentando metodo alternativo..." -ForegroundColor Yellow
    
    # Metodo alternativo: substituir linha por linha
    $lines = Get-Content $installerPath
    $newLines = @()
    $inFunction = $false
    $functionReplaced = $false
    
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]
        
        if ($line -match '^Function CreateDesktopShortcut$') {
            $inFunction = $true
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
            $functionReplaced = $true
            continue
        }
        
        if ($inFunction -and $line -match '^FunctionEnd$') {
            $newLines += "FunctionEnd"
            $inFunction = $false
            continue
        }
        
        if (-not $inFunction) {
            $newLines += $line
        }
    }
    
    if ($functionReplaced) {
        Set-Content -Path $installerPath -Value ($newLines -join "`n") -NoNewline
        Write-Host "  OK Funcao CreateDesktopShortcut modificada (metodo alternativo)" -ForegroundColor Green
        Write-Host ""
        Write-Host "Pronto! Agora execute 'npm run tauri:build' novamente para recompilar" -ForegroundColor Cyan
    } else {
        Write-Host "  ERRO: Nao foi possivel modificar o instalador" -ForegroundColor Red
        exit 1
    }
}

if ($modified) {
    Set-Content -Path $installerPath -Value $content -NoNewline
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "Modificacoes aplicadas com sucesso!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Agora recompile o instalador:" -ForegroundColor Cyan
    Write-Host "  npm run tauri:build" -ForegroundColor White
    Write-Host ""
    Write-Host "O instalador agora criara apenas 1 icone na area de trabalho!" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "ERRO: Nao foi possivel aplicar as modificacoes" -ForegroundColor Red
    Write-Host "Verifique se o arquivo installer.nsi foi gerado corretamente" -ForegroundColor Yellow
    exit 1
}

