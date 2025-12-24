#!/usr/bin/env python3
"""
Icon Generator for Tauri App
Converts a source icon image to all required Tauri icon formats.

Requirements:
    pip install Pillow

Usage:
    python generate-icons.py path/to/your/icon.png
"""

import sys
import os
from pathlib import Path

try:
    from PIL import Image
except ImportError:
    print("Error: Pillow is not installed.")
    print("Install it with: pip install Pillow")
    sys.exit(1)


def create_icons(source_path, output_dir):
    """Generate all required Tauri icon formats from source image."""
    
    if not os.path.exists(source_path):
        print(f"Error: Source image not found: {source_path}")
        return False
    
    # Create output directory if it doesn't exist
    output_dir = Path(output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)
    
    try:
        # Open source image
        img = Image.open(source_path)
        print(f"Source image: {img.size[0]}x{img.size[1]} pixels, format: {img.format}")
        
        # Ensure RGBA mode for transparency support
        if img.mode != 'RGBA':
            img = img.convert('RGBA')
        
        # Generate PNG sizes
        sizes = [
            (32, 32, "32x32.png"),
            (128, 128, "128x128.png"),
            (256, 256, "128x128@2x.png"),
        ]
        
        print("\nGenerating PNG icons...")
        for width, height, filename in sizes:
            resized = img.resize((width, height), Image.Resampling.LANCZOS)
            output_path = output_dir / filename
            resized.save(output_path, "PNG")
            print(f"  ✓ Created {filename} ({width}x{height})")
        
        # Generate Windows .ico file (with multiple sizes for high quality)
        print("\nGenerating Windows .ico file with multiple resolutions...")
        ico_sizes = [(256, 256), (128, 128), (64, 64), (48, 48), (32, 32), (16, 16)]
        ico_images = []
        for size in ico_sizes:
            resized = img.resize(size, Image.Resampling.LANCZOS)
            ico_images.append(resized)
        
        ico_path = output_dir / "icon.ico"
        # Save ICO with all sizes for high quality
        ico_images[0].save(ico_path, format='ICO', sizes=[(s.width, s.height) for s in ico_images])
        print(f"  ✓ Created icon.ico with resolutions: 16x16, 32x32, 48x48, 64x64, 128x128, 256x256")
        print(f"    This ensures high quality icons on Windows desktop!")
        
        # Note about .icns (macOS)
        print("\n⚠ macOS .icns file cannot be generated with Pillow.")
        print("  Options:")
        print("  1. Use iconutil on macOS: iconutil -c icns icon.iconset")
        print("  2. Use online converter: https://cloudconvert.com/png-to-icns")
        print("  3. Use ImageMagick: magick convert icon.png icon.icns")
        
        print(f"\n✓ Icon generation complete!")
        print(f"  Icons saved to: {output_dir}")
        print(f"\n  Missing: icon.icns (macOS) - create manually or use online tool")
        
        return True
        
    except Exception as e:
        print(f"Error processing image: {e}")
        return False


def main():
    if len(sys.argv) < 2:
        print("Usage: python generate-icons.py <source-icon.png>")
        print("\nExample:")
        print("  python generate-icons.py my-icon.png")
        print("  python generate-icons.py C:/path/to/icon.png")
        sys.exit(1)
    
    source_path = sys.argv[1]
    output_dir = "src-tauri/icons"
    
    print("Tauri Icon Generator")
    print("=" * 50)
    print(f"Source: {source_path}")
    print(f"Output: {output_dir}")
    print("=" * 50)
    
    success = create_icons(source_path, output_dir)
    
    if success:
        print("\n✓ Success! You can now build your Tauri app.")
        print("  Run: npm run tauri:build")
    else:
        sys.exit(1)


if __name__ == "__main__":
    main()

