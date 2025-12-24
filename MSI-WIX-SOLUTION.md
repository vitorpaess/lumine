# Solução: Usar MSI (WiX) ao Invés de NSIS

## ✅ Por Que MSI (WiX)?

O MSI (WiX) oferece melhor controle sobre atalhos:
- ✅ **Apenas 1 atalho** no Menu Iniciar (padrão do Windows)
- ❌ **Nenhum atalho** no Desktop (mais limpo)
- ✅ Local "oficial" do Windows
- ✅ Menos alertas de TI em ambientes corporativos

## 📋 Configuração Aplicada

```json
"bundle": {
  "targets": ["msi"],
  "windows": {
    "wix": {
      "language": "en-US",
      "enableElevatedUpdateTask": false
    }
  }
}
```

## 🚀 Como Usar

### Build Normal

```powershell
npm run tauri:build
```

### Resultado

O instalador será gerado em:
```
src-tauri/target/release/bundle/msi/Lumene_1.0.0_x64_en-US.msi
```

## ✅ Resultado Esperado

Após instalar o `.msi`:
- ✅ **1 atalho** no Menu Iniciar (local oficial do Windows)
- ❌ **Sem atalhos** no Desktop
- ✅ Mais limpo e profissional
- ✅ Melhor aceitação em ambientes corporativos

## 🎯 Vantagens do MSI

1. **Padrão corporativo**: MSI é o formato padrão para distribuição corporativa
2. **Melhor controle**: WiX oferece mais controle sobre atalhos
3. **Menos problemas**: Não cria atalhos duplicados ou do desinstalador
4. **Aceitação TI**: MSI é mais aceito por departamentos de TI

## 📝 Nota

O MSI cria apenas 1 atalho no Menu Iniciar por padrão, que é exatamente o que você quer! Não precisa de patches ou scripts adicionais.

## 🔄 Se Precisar Voltar para NSIS

Basta mudar `"targets": ["msi"]` para `"targets": ["nsis"]` ou `"targets": "all"`.


