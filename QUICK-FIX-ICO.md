# Correção Rápida: Erro icon.ico

## ❌ Erro Atual

```
error RC2175 : resource file icon.ico is not in 3.00 format
```

O `icon.ico` criado não está no formato correto que o Windows Resource Compiler espera.

## ✅ Solução Rápida (2 minutos)

### Opção 1: Converter Online (Mais Rápido)

1. **Acesse**: https://convertico.com/
2. **Clique em "Choose File"**
3. **Selecione**: `src-tauri\icons\128x128.png`
4. **Clique em "Convert ICO"**
5. **Baixe o arquivo**
6. **Renomeie para `icon.ico`** (se necessário)
7. **Substitua** o arquivo em `src-tauri\icons\icon.ico`

### Opção 2: Usar ImageMagick (Se Instalado)

```powershell
cd src-tauri\icons
magick convert 128x128.png -define icon:auto-resize=256,128,64,32,16 icon.ico
```

### Opção 3: Outro Conversor Online

- **CloudConvert**: https://cloudconvert.com/png-to-ico
- **ICO Convert**: https://icoconvert.com/

## Depois de Corrigir

Execute novamente:

```powershell
npm run tauri:dev
```

## Por Que Isso Aconteceu?

O método usado pelo PowerShell para criar ICO não gera o formato 3.00 que o Windows Resource Compiler requer. Ferramentas online ou ImageMagick criam ICOs no formato correto.

## Nota

Depois de converter, o `icon.ico` estará no formato correto e o build funcionará!

