# Script para gerar TODOS os icones necessarios a partir de uma imagem 1024x1024
# Uso: .\generate-all-icons-from-1024.ps1 C:\caminho\para\sua-imagem-1024x1024.png

param(
    [Parameter(Mandatory=$true)]
    [string]$sourceImage
)

$iconDir = "src-tauri\icons"

if (-not (Test-Path $iconDir)) {
    New-Item -ItemType Directory -Path $iconDir | Out-Null
}

if (-not (Test-Path $sourceImage)) {
    Write-Host "ERRO: Arquivo nao encontrado: $sourceImage" -ForegroundColor Red
    exit 1
}

Write-Host "Gerador de Icones Completo" -ForegroundColor Cyan
Write-Host "===========================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Imagem fonte: $sourceImage" -ForegroundColor Green
Write-Host "Diretorio de saida: $iconDir" -ForegroundColor Green
Write-Host ""

# Verificar ImageMagick
$magickAvailable = $false
try {
    $null = Get-Command magick -ErrorAction Stop
    $magickAvailable = $true
    Write-Host "ImageMagick encontrado! Gerando todos os icones..." -ForegroundColor Green
} catch {
    Write-Host "ImageMagick nao encontrado. Usando metodo alternativo..." -ForegroundColor Yellow
}

if ($magickAvailable) {
    Write-Host ""
    Write-Host "Gerando PNGs necessarios..." -ForegroundColor Cyan
    
    # Gerar todos os PNGs necessarios
    magick convert "$sourceImage" -resize 32x32 "$iconDir\32x32.png"
    Write-Host "  OK 32x32.png" -ForegroundColor Green
    
    magick convert "$sourceImage" -resize 128x128 "$iconDir\128x128.png"
    Write-Host "  OK 128x128.png" -ForegroundColor Green
    
    magick convert "$sourceImage" -resize 256x256 "$iconDir\128x128@2x.png"
    Write-Host "  OK 128x128@2x.png (256x256)" -ForegroundColor Green
    
    Write-Host ""
    Write-Host "Gerando ICO com multiplas resolucoes (alta qualidade)..." -ForegroundColor Cyan
    magick convert "$sourceImage" -define icon:auto-resize=256,128,64,48,32,16 "$iconDir\icon.ico"
    Write-Host "  OK icon.ico (com 6 resolucoes: 16, 32, 48, 64, 128, 256)" -ForegroundColor Green
    
    Write-Host ""
    Write-Host "AVISO: icon.icns (macOS) precisa ser criado separadamente" -ForegroundColor Yellow
    Write-Host "  Use: https://cloudconvert.com/png-to-icns" -ForegroundColor Cyan
    Write-Host "  Ou apenas ignore se so vai fazer build para Windows" -ForegroundColor Cyan
    
} else {
    # Metodo alternativo usando .NET
    Write-Host "Usando metodo alternativo (qualidade pode ser menor)..." -ForegroundColor Yellow
    Write-Host ""
    
    try {
        Add-Type -AssemblyName System.Drawing
        
        $source = [System.Drawing.Image]::FromFile($sourceImage)
        
        Write-Host "Gerando PNGs..." -ForegroundColor Cyan
        
        # Gerar PNGs
        $sizes = @(
            @{Size=32; File="32x32.png"},
            @{Size=128; File="128x128.png"},
            @{Size=256; File="128x128@2x.png"}
        )
        
        foreach ($item in $sizes) {
            $bitmap = New-Object System.Drawing.Bitmap($source, $item.Size, $item.Size)
            $bitmap.Save("$iconDir\$($item.File)", [System.Drawing.Imaging.ImageFormat]::Png)
            $bitmap.Dispose()
            Write-Host "  OK $($item.File)" -ForegroundColor Green
        }
        
        $source.Dispose()
        
        Write-Host ""
        Write-Host "IMPORTANTE: Para criar icon.ico de alta qualidade, use:" -ForegroundColor Yellow
        Write-Host "  1. ImageMagick: magick convert `"$sourceImage`" -define icon:auto-resize=256,128,64,48,32,16 `"$iconDir\icon.ico`"" -ForegroundColor Cyan
        Write-Host "  2. Ou online: https://convertico.com/" -ForegroundColor Cyan
        Write-Host "     - Faca upload de: $sourceImage" -ForegroundColor White
        Write-Host "     - Baixe e coloque em: $iconDir\icon.ico" -ForegroundColor White
        
    } catch {
        Write-Host "Erro: $_" -ForegroundColor Red
        Write-Host ""
        Write-Host "Use ferramentas online:" -ForegroundColor Yellow
        Write-Host "  - PNGs: Use qualquer editor de imagens para redimensionar" -ForegroundColor Cyan
        Write-Host "  - ICO: https://convertico.com/" -ForegroundColor Cyan
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Arquivos necessarios para Tauri:" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Windows (obrigatorio):" -ForegroundColor Green
Write-Host "  [x] 32x32.png" -ForegroundColor $(if (Test-Path "$iconDir\32x32.png") {"Green"} else {"Red"})
Write-Host "  [x] 128x128.png" -ForegroundColor $(if (Test-Path "$iconDir\128x128.png") {"Green"} else {"Red"})
Write-Host "  [x] 128x128@2x.png" -ForegroundColor $(if (Test-Path "$iconDir\128x128@2x.png") {"Green"} else {"Red"})
Write-Host "  [x] icon.ico" -ForegroundColor $(if (Test-Path "$iconDir\icon.ico") {"Green"} else {"Yellow"})
Write-Host ""
Write-Host "macOS (opcional - apenas se for fazer build no Mac):" -ForegroundColor Yellow
Write-Host "  [ ] icon.icns" -ForegroundColor $(if (Test-Path "$iconDir\icon.icns") {"Green"} else {"Yellow"})
Write-Host "     Use: https://cloudconvert.com/png-to-icns" -ForegroundColor Cyan
Write-Host ""
Write-Host "Pronto! Agora execute: npm run tauri:build" -ForegroundColor Green

