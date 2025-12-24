# Script para criar icones placeholder temporarios
# Execute: .\create-placeholder-icons.ps1

$iconDir = "src-tauri\icons"

if (-not (Test-Path $iconDir)) {
    New-Item -ItemType Directory -Path $iconDir | Out-Null
}

Write-Host "Criando icones placeholder temporarios..." -ForegroundColor Yellow
Write-Host ""

try {
    Add-Type -AssemblyName System.Drawing
    
    function Create-PNGIcon {
        param($size, $filename)
        $bitmap = New-Object System.Drawing.Bitmap($size, $size)
        $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
        $graphics.Clear([System.Drawing.Color]::FromArgb(102, 126, 234))
        $brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
        $fontSize = [Math]::Max(8, $size / 4)
        $font = New-Object System.Drawing.Font("Arial", $fontSize, [System.Drawing.FontStyle]::Bold)
        $x = ($size - ($graphics.MeasureString("L", $font).Width)) / 2
        $y = ($size - ($graphics.MeasureString("L", $font).Height)) / 2
        $graphics.DrawString("L", $font, $brush, $x, $y)
        $graphics.Dispose()
        $bitmap.Save("$iconDir\$filename", [System.Drawing.Imaging.ImageFormat]::Png)
        $bitmap.Dispose()
        Write-Host "  OK Criado: $filename" -ForegroundColor Green
    }
    
    Create-PNGIcon -size 32 -filename "32x32.png"
    Create-PNGIcon -size 128 -filename "128x128.png"
    Create-PNGIcon -size 256 -filename "128x128@2x.png"
    
    # Criar ICO basico (copiando 128x128)
    $icoBitmap = New-Object System.Drawing.Bitmap(128, 128)
    $icoGraphics = [System.Drawing.Graphics]::FromImage($icoBitmap)
    $icoGraphics.Clear([System.Drawing.Color]::FromArgb(102, 126, 234))
    $icoBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
    $icoFont = New-Object System.Drawing.Font("Arial", 32, [System.Drawing.FontStyle]::Bold)
    $icoGraphics.DrawString("L", $icoFont, $icoBrush, 40, 40)
    $icoGraphics.Dispose()
    $icoBitmap.Save("$iconDir\icon.ico", [System.Drawing.Imaging.ImageFormat]::Icon)
    $icoBitmap.Dispose()
    Write-Host "  OK Criado: icon.ico" -ForegroundColor Green
    
    Write-Host ""
    Write-Host "AVISO: icon.icns precisa ser criado manualmente (apenas para macOS)" -ForegroundColor Yellow
    Write-Host "Use: https://cloudconvert.com/png-to-icns" -ForegroundColor Cyan
    
} catch {
    Write-Host "Erro: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "Solucao alternativa:" -ForegroundColor Yellow
    Write-Host "1. Crie uma imagem 256x256 pixels" -ForegroundColor Yellow
    Write-Host "2. Use: https://convertico.com/ para criar icon.ico" -ForegroundColor Yellow
    Write-Host "3. Coloque os arquivos em: $iconDir\" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Arquivos em: $iconDir\" -ForegroundColor Green
Write-Host "Execute: npm run tauri:dev" -ForegroundColor Cyan
