# Criação Rápida de Ícones

## ✅ Ícones Placeholder Criados

Os ícones placeholder foram criados com sucesso! Eles permitem que você teste o aplicativo agora.

**Arquivos criados:**
- ✅ `32x32.png`
- ✅ `128x128.png`
- ✅ `128x128@2x.png` (256x256)
- ✅ `icon.ico` (Windows)

**Falta apenas:**
- ⚠️ `icon.icns` (macOS - necessário apenas se você for construir no macOS)

## 🚀 Próximo Passo

Agora você pode executar:

```powershell
npm run tauri:dev
```

O aplicativo deve compilar e abrir!

## 🎨 Substituir por Ícones Reais

Quando estiver pronto para criar os ícones finais:

1. **Tenha sua imagem de ícone** (1024x1024 PNG recomendado)

2. **Use o script Python** (se tiver Python instalado):
   ```powershell
   pip install Pillow
   python generate-icons.py seu-icone.png
   ```

3. **Ou use ferramentas online**:
   - PNG para ICO: https://convertico.com/
   - PNG para ICNS: https://cloudconvert.com/png-to-icns
   - Para redimensionar PNGs: Use qualquer editor de imagens

4. **Ou use ImageMagick** (se instalado):
   ```powershell
   cd src-tauri\icons
   magick convert seu-icone.png -resize 32x32 32x32.png
   magick convert seu-icone.png -resize 128x128 128x128.png
   magick convert seu-icone.png -resize 256x256 128x128@2x.png
   magick convert seu-icone.png -define icon:auto-resize=256,128,64,32,16 icon.ico
   ```

## 📝 Nota

Os ícones placeholder são temporários e mostram apenas a letra "L" em um fundo azul. Substitua-os pelos ícones reais antes de distribuir o aplicativo!

