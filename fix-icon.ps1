# Script para corrigir o icon.ico
# O problema: icon.ico precisa estar no formato 3.00 para o Windows Resource Compiler

$iconDir = "src-tauri\icons"
$pngFile = "$iconDir\128x128.png"

Write-Host "Corrigindo icon.ico..." -ForegroundColor Yellow
Write-Host ""

# Verificar se ImageMagick esta disponivel
$magickAvailable = $false
try {
    $null = Get-Command magick -ErrorAction Stop
    $magickAvailable = $true
    Write-Host "ImageMagick encontrado! Usando para criar ICO valido..." -ForegroundColor Green
} catch {
    Write-Host "ImageMagick nao encontrado." -ForegroundColor Yellow
}

if ($magickAvailable) {
    # Usar ImageMagick para criar ICO valido com multiplos tamanhos
    Write-Host "Criando icon.ico com ImageMagick..." -ForegroundColor Cyan
    magick convert "$pngFile" -define icon:auto-resize=256,128,64,48,32,16 "$iconDir\icon.ico"
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  OK icon.ico criado com sucesso!" -ForegroundColor Green
        Write-Host ""
        Write-Host "Agora execute: npm run tauri:dev" -ForegroundColor Cyan
        exit 0
    }
}

# Se ImageMagick nao funcionou, instruir conversao online
Write-Host ""
Write-Host "SOLUCAO: Converter PNG para ICO online" -ForegroundColor Yellow
Write-Host ""
Write-Host "Opcao 1 - Convertico (Recomendado):" -ForegroundColor Cyan
Write-Host "  1. Acesse: https://convertico.com/" -ForegroundColor White
Write-Host "  2. Clique em 'Choose File' e selecione: $pngFile" -ForegroundColor White
Write-Host "  3. Clique em 'Convert ICO'" -ForegroundColor White
Write-Host "  4. Baixe o arquivo e renomeie para 'icon.ico'" -ForegroundColor White
Write-Host "  5. Coloque em: $iconDir\" -ForegroundColor White
Write-Host ""
Write-Host "Opcao 2 - CloudConvert:" -ForegroundColor Cyan
Write-Host "  1. Acesse: https://cloudconvert.com/png-to-ico" -ForegroundColor White
Write-Host "  2. Faça upload de: $pngFile" -ForegroundColor White
Write-Host "  3. Baixe e coloque como: $iconDir\icon.ico" -ForegroundColor White
Write-Host ""
Write-Host "Depois de criar o icon.ico, execute: npm run tauri:dev" -ForegroundColor Green

