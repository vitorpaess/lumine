@echo off
REM Icon Generator Batch Script for Windows
REM This script helps generate Tauri icons using ImageMagick (if installed)

echo Tauri Icon Generator for Windows
echo ====================================
echo.

REM Check if ImageMagick is installed
where magick >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ImageMagick is not installed or not in PATH.
    echo.
    echo Please either:
    echo 1. Install ImageMagick from https://imagemagick.org/script/download.php
    echo 2. Or use the Python script: python generate-icons.py your-icon.png
    echo 3. Or use online tools (see generate-icons.md)
    echo.
    pause
    exit /b 1
)

if "%~1"=="" (
    echo Usage: generate-icons.bat ^<source-icon.png^>
    echo.
    echo Example:
    echo   generate-icons.bat my-icon.png
    echo.
    pause
    exit /b 1
)

set SOURCE_ICON=%~1
set OUTPUT_DIR=src-tauri\icons

if not exist "%SOURCE_ICON%" (
    echo Error: Source icon not found: %SOURCE_ICON%
    pause
    exit /b 1
)

echo Source icon: %SOURCE_ICON%
echo Output directory: %OUTPUT_DIR%
echo.

REM Create output directory
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

echo Generating PNG icons...
magick convert "%SOURCE_ICON%" -resize 32x32 "%OUTPUT_DIR%\32x32.png"
magick convert "%SOURCE_ICON%" -resize 128x128 "%OUTPUT_DIR%\128x128.png"
magick convert "%SOURCE_ICON%" -resize 256x256 "%OUTPUT_DIR%\128x128@2x.png"

echo Generating Windows .ico file...
magick convert "%SOURCE_ICON%" -define icon:auto-resize=256,128,64,32,16 "%OUTPUT_DIR%\icon.ico"

echo.
echo ✓ PNG and ICO files generated successfully!
echo.
echo ⚠ Note: macOS .icns file cannot be generated on Windows.
echo   Please use an online converter like https://cloudconvert.com/png-to-icns
echo   or generate it on a Mac using: iconutil -c icns icon.iconset
echo.
echo Icons saved to: %OUTPUT_DIR%
echo.
pause

