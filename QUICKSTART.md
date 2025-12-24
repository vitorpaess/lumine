# Quick Start Guide

## First Time Setup

1. **Install Prerequisites**:
   ```bash
   # Install Rust (if not already installed)
   # Visit https://rustup.rs/ and follow instructions
   
   # Verify installations
   rustc --version
   node --version
   npm --version
   ```

2. **Install Dependencies**:
   ```bash
   npm install
   ```

3. **Add App Icons** (Required before building):
   - See `ICONS.md` for detailed instructions
   - You need to add icon files to `src-tauri/icons/` before building
   - Minimum: Create a 1024x1024 PNG and convert it to the required formats

4. **Verify the Website URL**:
   - The app is configured to load from https://vitorgravity.lovable.app/
   - To change it, edit `src-tauri/tauri.conf.json` and update the `devPath` value

## Development

```bash
npm run tauri:dev
```

This starts the development server and opens the app window.

## Building for Distribution

### Windows (.exe)
```bash
npm run tauri:build
```
Output: `src-tauri/target/release/bundle/nsis/Lumene_1.0.0_x64-setup.exe`

### macOS (.dmg)
On a Mac:
```bash
npm run tauri:build
```
Output: `src-tauri/target/release/bundle/dmg/Lumene_1.0.0_x64.dmg`

### Cross-Platform Building
- **Windows .exe**: Must build on Windows
- **macOS .dmg**: Must build on macOS
- **Linux packages**: Must build on Linux

For cross-platform builds, use CI/CD (GitHub Actions, etc.) or build on each platform separately.

## Next Steps

1. Customize `src-tauri/tauri.conf.json` with your app details
2. Add your app code to the `src/` directory
3. Test in development mode
4. Build and distribute!

