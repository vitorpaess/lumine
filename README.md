# Lumene - Tauri Desktop App

A desktop application built with Tauri that wraps your existing web app hosted at [https://vitorgravity.lovable.app/](https://vitorgravity.lovable.app/).

## Prerequisites

Before building, make sure you have:

1. **Node.js** (v16 or later) - [Download](https://nodejs.org/)
2. **Rust** - Install from [rustup.rs](https://rustup.rs/)
3. **System Dependencies**:
   - **Windows**: Microsoft Visual Studio C++ Build Tools or Visual Studio 2019+
   - **macOS**: Xcode Command Line Tools (`xcode-select --install`)
   - **Linux**: `libwebkit2gtk-4.0-dev`, `build-essential`, `curl`, `wget`, `libssl-dev`, `libgtk-3-dev`, `libayatana-appindicator3-dev`, `librsvg2-dev`

## Installation

1. Install dependencies:
```bash
npm install
```

2. Install Tauri CLI (if not already installed):
```bash
npm install -g @tauri-apps/cli
```

## Development

Run the app in development mode:
```bash
npm run tauri:dev
```

This will:
- Launch the Tauri window loading your app from https://vitorgravity.lovable.app/
- The app will automatically reload when you make changes to the Tauri configuration

## Building

### Build for Current Platform

Build the app for your current platform:
```bash
npm run tauri:build
```

### Build Outputs

After building, you'll find:

- **Windows**: `.exe` installer in `src-tauri/target/release/bundle/nsis/`
- **macOS**: `.dmg` file in `src-tauri/target/release/bundle/dmg/`
- **Linux**: `.deb` and `.AppImage` in `src-tauri/target/release/bundle/`

## Customizing Your App

1. **Change the website URL**: Edit `src-tauri/tauri.conf.json` and update the `devPath` in the `build` section to point to a different URL
2. **Update app metadata**: Edit `src-tauri/tauri.conf.json` to change:
   - App name (`productName`)
   - Window title
   - Window size
   - Bundle identifier
3. **Add icons**: 
   - Create a 1024x1024 PNG image of your app icon
   - Use an online tool like [CloudConvert](https://cloudconvert.com/) or [ImageMagick](https://imagemagick.org/) to generate:
     - `32x32.png`
     - `128x128.png`
     - `128x128@2x.png` (256x256)
     - `icon.icns` (macOS - use `iconutil` or online converter)
     - `icon.ico` (Windows - use online converter or ImageMagick)
   - Place all icon files in `src-tauri/icons/`
4. **Configure features**: Edit `src-tauri/Cargo.toml` and `src-tauri/tauri.conf.json` to enable/disable Tauri features

**Note**: This app loads from a remote URL (https://vitorgravity.lovable.app/). The local `src/` directory files are not used but kept for reference. To switch to local files, update the `devPath` in `tauri.conf.json` and configure the build process accordingly.

## Project Structure

```
.
├── src/              # (Not used - app loads from remote URL)
│   ├── main.js      # Reference files
│   └── styles.css   # 
├── index.html        # (Not used - app loads from remote URL)
├── src-tauri/        # Tauri backend (Rust)
│   ├── src/
│   │   └── main.rs  # Rust entry point
│   ├── Cargo.toml   # Rust dependencies
│   ├── tauri.conf.json  # Tauri configuration (points to remote URL)
│   └── icons/       # App icons (add your icons here)
├── package.json      # Node.js dependencies
└── vite.config.js    # (Not used - app loads from remote URL)
```

**Note**: The app is configured to load from https://vitorgravity.lovable.app/. Local frontend files are not used but kept for reference.

## Troubleshooting

- **Build fails on Windows**: Make sure you have Visual Studio Build Tools installed
- **Build fails on macOS**: Run `xcode-select --install` to install command line tools
- **Port already in use**: Change the port in `vite.config.js` if 1420 is taken

## Resources

- [Tauri Documentation](https://tauri.app/)
- [Tauri API Reference](https://tauri.app/api/)
- [Vite Documentation](https://vitejs.dev/)

