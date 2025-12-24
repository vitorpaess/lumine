# Icon Generation Guide

You have an icon image that needs to be converted to the required Tauri formats.

## Quick Method (Recommended)

### Option 1: Using Online Tools

1. **Save your icon image** as `icon-source.png` (1024x1024 or larger, PNG format) in the `src-tauri/icons/` directory

2. **Use an online converter**:
   - Visit [CloudConvert](https://cloudconvert.com/) or [ConvertICO](https://convertico.com/)
   - Convert your PNG to:
     - `.ico` format (for Windows) - save as `icon.ico`
     - `.icns` format (for macOS) - save as `icon.icns`

3. **Generate PNG sizes**:
   - Use an image editor (Photoshop, GIMP, Paint.NET, etc.) or online tool to create:
     - `32x32.png` (32x32 pixels)
     - `128x128.png` (128x128 pixels)
     - `128x128@2x.png` (256x256 pixels - this is the Retina/high-DPI version)

4. **Place all files** in `src-tauri/icons/`:
   ```
   src-tauri/icons/
   ├── 32x32.png
   ├── 128x128.png
   ├── 128x128@2x.png
   ├── icon.icns
   └── icon.ico
   ```

### Option 2: Using ImageMagick (Command Line)

If you have ImageMagick installed:

```bash
cd src-tauri/icons

# Resize to required PNG sizes
magick convert icon-source.png -resize 32x32 32x32.png
magick convert icon-source.png -resize 128x128 128x128.png
magick convert icon-source.png -resize 256x256 128x128@2x.png

# Create Windows .ico (with multiple sizes)
magick convert icon-source.png -define icon:auto-resize=256,128,64,32,16 icon.ico

# Create macOS .icns (requires iconutil on macOS)
# First create iconset directory structure, then:
iconutil -c icns icon.iconset
```

### Option 3: Using Python Script

See `generate-icons.py` for an automated script (requires Pillow library).

## Icon Requirements

- **Format**: PNG for raster images, or SVG (but Tauri needs PNG/ICO/ICNS)
- **Recommended source size**: 1024x1024 pixels or larger
- **Background**: Your icon has a black background, which is fine
- **Transparency**: Optional, but can be useful

## File Checklist

Before building, ensure you have all these files in `src-tauri/icons/`:

- [ ] `32x32.png`
- [ ] `128x128.png`
- [ ] `128x128@2x.png` (256x256)
- [ ] `icon.ico` (Windows)
- [ ] `icon.icns` (macOS)

## Testing

After adding icons, test the build:
```bash
npm run tauri:dev
```

The app window should show your icon in the title bar and taskbar.

