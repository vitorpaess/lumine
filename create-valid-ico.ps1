# Script para criar um ICO valido usando metodo alternativo
$iconDir = "src-tauri\icons"
$pngFile = "$iconDir\128x128.png"
$icoFile = "$iconDir\icon.ico"

Write-Host "Criando ICO valido..." -ForegroundColor Yellow

# Tentar usar PowerShell para criar ICO via .NET com metodo diferente
try {
    Add-Type -AssemblyName System.Drawing
    
    # Carregar o PNG existente
    $png = [System.Drawing.Image]::FromFile($pngFile)
    
    # Criar um ICO valido usando Icon.Save que cria formato correto
    # Mas primeiro precisamos criar um Icon object, nao Bitmap
    
    # Metodo alternativo: usar System.Drawing.Icon
    # Criar um Icon a partir do Bitmap
    $bitmap = New-Object System.Drawing.Bitmap($png)
    
    # Salvar como ICO usando um metodo que funciona
    # Infelizmente, .NET nao tem suporte direto para criar ICO valido
    # Vamos copiar o PNG e instruir conversao
    
    Write-Host ""
    Write-Host "AVISO: .NET nao pode criar ICO valido diretamente." -ForegroundColor Yellow
    Write-Host "Por favor, use uma ferramenta online para converter." -ForegroundColor Yellow
    Write-Host ""
    
    $png.Dispose()
    $bitmap.Dispose()
    
} catch {
    Write-Host "Erro: $_" -ForegroundColor Red
}

Write-Host "SOLUCAO RAPIDA:" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Abra: https://convertico.com/" -ForegroundColor White
Write-Host "2. Faça upload de: $pngFile" -ForegroundColor White  
Write-Host "3. Baixe o ICO e substitua: $icoFile" -ForegroundColor White
Write-Host ""
Write-Host "OU instale ImageMagick e execute:" -ForegroundColor Cyan
Write-Host "  magick convert `"$pngFile`" -define icon:auto-resize=256,128,64,32,16 `"$icoFile`"" -ForegroundColor White

