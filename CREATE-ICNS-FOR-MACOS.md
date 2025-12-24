# Criar icon.icns para macOS

## 🎯 Método Simples

### Opção 1: Converter Online (Mais Fácil)

1. **Acesse**: https://cloudconvert.com/png-to-icns
   - Ou: https://convertio.co/png-icns/
   - Ou: https://ezgif.com/png-to-icns

2. **Faça upload**:
   - Sua imagem PNG 1024x1024 (recomendado)
   - Ou seu arquivo ICO (alguns conversores aceitam)

3. **Converta** para ICNS

4. **Baixe** o arquivo

5. **Renomeie** para `icon.icns` e coloque em:
   ```
   src-tauri\icons\icon.icns
   ```

### Opção 2: Usar ImageMagick (Se Instalado)

```powershell
cd src-tauri\icons
magick convert sua-imagem-1024x1024.png icon.icns
```

**Nota**: ImageMagick no Windows pode não suportar ICNS diretamente. Use a opção online.

### Opção 3: No macOS (Se Você Tem Mac)

Se você tem acesso a um Mac:

```bash
# Criar estrutura de ícones
mkdir icon.iconset

# Gerar todos os tamanhos necessários
sips -z 16 16     sua-imagem-1024x1024.png --out icon.iconset/icon_16x16.png
sips -z 32 32     sua-imagem-1024x1024.png --out icon.iconset/icon_16x16@2x.png
sips -z 32 32     sua-imagem-1024x1024.png --out icon.iconset/icon_32x32.png
sips -z 64 64     sua-imagem-1024x1024.png --out icon.iconset/icon_32x32@2x.png
sips -z 128 128   sua-imagem-1024x1024.png --out icon.iconset/icon_128x128.png
sips -z 256 256   sua-imagem-1024x1024.png --out icon.iconset/icon_128x128@2x.png
sips -z 256 256   sua-imagem-1024x1024.png --out icon.iconset/icon_256x256.png
sips -z 512 512   sua-imagem-1024x1024.png --out icon.iconset/icon_256x256@2x.png
sips -z 512 512   sua-imagem-1024x1024.png --out icon.iconset/icon_512x512.png
sips -z 1024 1024 sua-imagem-1024x1024.png --out icon.iconset/icon_512x512@2x.png

# Converter para ICNS
iconutil -c icns icon.iconset

# Mover para o diretório correto
mv icon.icns ../src-tauri/icons/
```

## ✅ Checklist

- [ ] Tenho minha imagem PNG 1024x1024 (ou ICO)
- [ ] Usei ferramenta online para converter para ICNS
- [ ] Baixei o arquivo `icon.icns`
- [ ] Coloquei em `src-tauri\icons\icon.icns`
- [ ] Verifiquei que o arquivo está no lugar certo

## 📝 Nota Importante

O `icon.icns` é **opcional** se você só vai fazer build para Windows. Mas é **necessário** se você:
- Vai fazer build no macOS
- Quer criar um arquivo `.dmg` para distribuir no Mac

## 🎯 Resumo Rápido

**Mais fácil**: Use https://cloudconvert.com/png-to-icns
1. Upload da sua imagem 1024x1024
2. Converta
3. Baixe e coloque em `src-tauri\icons\icon.icns`

Pronto! 🎉

