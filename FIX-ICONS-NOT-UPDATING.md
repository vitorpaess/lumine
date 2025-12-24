# Fix: Ícones Não Atualizam no Build

Se você substituiu os ícones mas eles não aparecem atualizados no build, siga estes passos:

## 🔧 Solução: Limpar Cache e Rebuild

### Passo 1: Limpar Cache do Rust

```powershell
cd src-tauri
cargo clean
cd ..
```

Isso remove todos os arquivos compilados e força uma rebuild completa.

### Passo 2: Limpar Cache do Tauri (Opcional)

```powershell
# Remover diretório target (cuidado - isso remove tudo compilado)
Remove-Item -Recurse -Force src-tauri\target
```

**Nota**: Isso vai fazer uma rebuild completa que pode levar mais tempo.

### Passo 3: Verificar se os Ícones Foram Substituídos

Certifique-se de que os arquivos em `src-tauri\icons\` são realmente os novos:

```powershell
# Verificar data de modificação dos arquivos
Get-ChildItem src-tauri\icons\ | Select-Object Name, LastWriteTime
```

Se os arquivos não foram atualizados recentemente, você pode ter substituído no lugar errado.

### Passo 4: Rebuild Completo

```powershell
npm run tauri:build
```

## ✅ Verificação Rápida

Antes de rebuild, verifique:

1. **Os arquivos estão no lugar certo?**
   ```
   src-tauri\icons\icon.ico
   src-tauri\icons\icon.icns
   src-tauri\icons\32x32.png
   src-tauri\icons\128x128.png
   src-tauri\icons\128x128@2x.png
   ```

2. **Os arquivos são realmente novos?**
   - Verifique a data de modificação
   - Abra um dos arquivos para confirmar que é o novo

3. **Não há cache do Windows?**
   - Às vezes o Windows cacheia ícones
   - Após instalar, pode precisar atualizar a visualização (F5 na área de trabalho)

## 🎯 Comando Completo (Tudo de Uma Vez)

```powershell
# Limpar cache
cd src-tauri
cargo clean
cd ..

# Rebuild
npm run tauri:build
```

## 🔍 Se Ainda Não Funcionar

1. **Verifique o caminho dos ícones no `tauri.conf.json`**:
   ```json
   "icon": [
     "icons/32x32.png",
     "icons/128x128.png",
     "icons/128x128@2x.png",
     "icons/icon.icns",
     "icons/icon.ico"
   ]
   ```

2. **Verifique se os nomes dos arquivos estão corretos** (case-sensitive em alguns sistemas)

3. **Tente deletar o diretório `target` completamente**:
   ```powershell
   Remove-Item -Recurse -Force src-tauri\target
   npm run tauri:build
   ```

4. **Verifique se o ICO tem múltiplas resoluções** (pode estar usando cache do ICO antigo)

## 💡 Dica

Após instalar o novo `.exe`, o Windows pode mostrar o ícone antigo por causa do cache. Tente:
- Atualizar a visualização (F5 na área de trabalho)
- Ou desinstalar e reinstalar o aplicativo

