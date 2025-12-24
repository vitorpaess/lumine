# Script para criar icones de alta qualidade
# Execute: .\create-high-quality-icons.ps1 [caminho-para-imagem-fonte.png]

param(
    [string]$sourceImage = ""
)

$iconDir = "src-tauri\icons"

if (-not (Test-Path $iconDir)) {
    New-Item -ItemType Directory -Path $iconDir | Out-Null
}

Write-Host "Criador de Icones de Alta Qualidade" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

if ($sourceImage -eq "") {
    Write-Host "USO: .\create-high-quality-icons.ps1 [caminho-para-imagem.png]" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Exemplo:" -ForegroundColor Yellow
    Write-Host "  .\create-high-quality-icons.ps1 C:\Users\SeuUsuario\Desktop\meu-icone.png" -ForegroundColor White
    Write-Host ""
    Write-Host "A imagem fonte deve ser:" -ForegroundColor Yellow
    Write-Host "  - Quadrada (ex: 1024x1024 ou 512x512)" -ForegroundColor White
    Write-Host "  - Formato PNG (recomendado)" -ForegroundColor White
    Write-Host "  - Alta qualidade" -ForegroundColor White
    Write-Host ""
    Write-Host "Se nao tiver uma imagem, use ferramentas online:" -ForegroundColor Cyan
    Write-Host "  1. Crie/edite sua imagem (1024x1024 PNG)" -ForegroundColor White
    Write-Host "  2. Use: https://convertico.com/ para criar ICO com multiplas resolucoes" -ForegroundColor White
    Write-Host "  3. Ou use ImageMagick: magick convert imagem.png -define icon:auto-resize=256,128,64,48,32,16 icon.ico" -ForegroundColor White
    exit 1
}

if (-not (Test-Path $sourceImage)) {
    Write-Host "ERRO: Arquivo nao encontrado: $sourceImage" -ForegroundColor Red
    exit 1
}

Write-Host "Imagem fonte: $sourceImage" -ForegroundColor Green
Write-Host "Diretorio de saida: $iconDir" -ForegroundColor Green
Write-Host ""

# Verificar ImageMagick
$magickAvailable = $false
try {
    $null = Get-Command magick -ErrorAction Stop
    $magickAvailable = $true
    Write-Host "ImageMagick encontrado! Criando icones de alta qualidade..." -ForegroundColor Green
} catch {
    Write-Host "ImageMagick nao encontrado." -ForegroundColor Yellow
    Write-Host "Instalando ImageMagick e recomendado para melhor qualidade." -ForegroundColor Yellow
    Write-Host "Download: https://imagemagick.org/script/download.php" -ForegroundColor Cyan
    Write-Host ""
}

if ($magickAvailable) {
    Write-Host "Gerando PNGs em diferentes resolucoes..." -ForegroundColor Cyan
    
    # Criar PNGs em diferentes tamanhos
    magick convert "$sourceImage" -resize 32x32 "$iconDir\32x32.png"
    magick convert "$sourceImage" -resize 128x128 "$iconDir\128x128.png"
    magick convert "$sourceImage" -resize 256x256 "$iconDir\128x128@2x.png"
    
    Write-Host "  OK PNGs criados" -ForegroundColor Green
    Write-Host ""
    
    Write-Host "Criando ICO com multiplas resolucoes (alta qualidade)..." -ForegroundColor Cyan
    # Criar ICO com todas as resolucoes necessarias
    magick convert "$sourceImage" -define icon:auto-resize=256,128,64,48,32,16 "$iconDir\icon.ico"
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  OK icon.ico criado com alta qualidade!" -ForegroundColor Green
        Write-Host ""
        Write-Host "O ICO contem as seguintes resolucoes:" -ForegroundColor Cyan
        Write-Host "  - 16x16, 32x32, 48x48, 64x64, 128x128, 256x256" -ForegroundColor White
        Write-Host ""
        Write-Host "AVISO: icon.icns precisa ser criado manualmente (apenas para macOS)" -ForegroundColor Yellow
        Write-Host "Use: https://cloudconvert.com/png-to-icns" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Pronto! Agora execute: npm run tauri:build" -ForegroundColor Green
    } else {
        Write-Host "  ERRO ao criar ICO" -ForegroundColor Red
    }
} else {
    # Usar .NET como fallback (qualidade menor)
    Write-Host "Usando metodo alternativo (qualidade limitada)..." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "RECOMENDADO: Instale ImageMagick para melhor qualidade" -ForegroundColor Yellow
    Write-Host ""
    
    try {
        Add-Type -AssemblyName System.Drawing
        
        $source = [System.Drawing.Image]::FromFile($sourceImage)
        
        # Criar PNGs
        $sizes = @(32, 128, 256)
        foreach ($size in $sizes) {
            $bitmap = New-Object System.Drawing.Bitmap($source, $size, $size)
            $filename = if ($size -eq 256) { "128x128@2x.png" } else { "${size}x${size}.png" }
            $bitmap.Save("$iconDir\$filename", [System.Drawing.Imaging.ImageFormat]::Png)
            $bitmap.Dispose()
            Write-Host "  OK Criado: $filename" -ForegroundColor Green
        }
        
        $source.Dispose()
        
        Write-Host ""
        Write-Host "IMPORTANTE: Para criar ICO de alta qualidade, use:" -ForegroundColor Yellow
        Write-Host "  1. ImageMagick: magick convert `"$sourceImage`" -define icon:auto-resize=256,128,64,48,32,16 `"$iconDir\icon.ico`"" -ForegroundColor Cyan
        Write-Host "  2. Ou online: https://convertico.com/" -ForegroundColor Cyan
        Write-Host "     - Faca upload de: $sourceImage" -ForegroundColor White
        Write-Host "     - Baixe e coloque em: $iconDir\icon.ico" -ForegroundColor White
        
    } catch {
        Write-Host "Erro: $_" -ForegroundColor Red
        Write-Host ""
        Write-Host "Use ferramentas online:" -ForegroundColor Yellow
        Write-Host "  https://convertico.com/ - Para criar ICO" -ForegroundColor Cyan
    }
}

Write-Host ""

