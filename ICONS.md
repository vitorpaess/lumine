# Icon Setup Guide

Tauri requires specific icon files for building desktop applications. Here's how to set them up:

**⚠️ Problema com qualidade do ícone?** Veja [HIGH-QUALITY-ICONS.md](HIGH-QUALITY-ICONS.md) para criar ícones de alta qualidade com múltiplas resoluções.

## Quick Setup (Using Tauri CLI v2 - if available)

If you have Tauri CLI v2 installed, you can generate icons automatically:

```bash
tauri icon path/to/your/icon.png
```

This will generate all required icon formats from a single 1024x1024 PNG image.

## Manual Setup

If you need to create icons manually:

### Required Icon Files

Place these files in `src-tauri/icons/`:

1. **32x32.png** - 32x32 pixel PNG
2. **128x128.png** - 128x128 pixel PNG  
3. **128x128@2x.png** - 256x256 pixel PNG (for Retina displays)
4. **icon.icns** - macOS icon format
5. **icon.ico** - Windows icon format

### Creating Icons

1. **Start with a 1024x1024 PNG** image of your app icon

2. **Generate PNG sizes**:
   - Use an image editor (Photoshop, GIMP, etc.) to resize to 32x32, 128x128, and 256x256
   - Or use ImageMagick: `magick convert icon.png -resize 32x32 32x32.png`

3. **Create .icns (macOS)**:
   - On macOS: Use `iconutil` command or online converters
   - Or use: [CloudConvert](https://cloudconvert.com/png-to-icns)

4. **Create .ico (Windows)** - **IMPORTANTE para alta qualidade**:
   - **Para alta qualidade**, o ICO deve conter múltiplas resoluções: 16x16, 32x32, 48x48, 64x64, 128x128, 256x256
   - **ImageMagick** (recomendado): `magick convert icon.png -define icon:auto-resize=256,128,64,48,32,16 icon.ico`
   - **Online**: Use [Convertico](https://convertico.com/) - alguns conversores criam múltiplas resoluções automaticamente
   - **Script automatizado**: Execute `.\create-high-quality-icons.ps1 seu-icone.png`

### Online Tools

- [CloudConvert](https://cloudconvert.com/) - Convert between icon formats
- [IconKitchen](https://icon.kitchen/) - Generate app icons
- [RealFaviconGenerator](https://realfavicongenerator.net/) - Generate multiple formats

### Temporary Placeholder

If you just want to test the build, you can create simple colored square icons temporarily. The build will work, but you'll want proper icons before distributing your app.

