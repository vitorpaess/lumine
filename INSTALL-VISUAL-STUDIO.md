# Instalando Visual Studio Build Tools

O Rust no Windows precisa do linker do Visual Studio para compilar. Siga estes passos:

## Erro que você está vendo

```
error: linker `link.exe` not found
note: please ensure that Visual Studio 2017 or later, or Build Tools for Visual Studio were installed with the Visual C++ option.
```

## Solução: Instalar Visual Studio Build Tools

### Método 1: Build Tools (Recomendado - Mais Leve)

1. **Baixe o Visual Studio Build Tools**:
   - Acesse: https://visualstudio.microsoft.com/downloads/
   - Role até "All downloads" → "Tools for Visual Studio"
   - Clique em "Build Tools for Visual Studio 2022" (ou 2019)
   - Baixe o instalador

2. **Execute o instalador**:
   - Execute `vs_buildtools.exe`
   - Na tela de seleção de componentes, marque:
     - ✅ **"Desktop development with C++"**
     - Isso inclui:
       - MSVC v143 - VS 2022 C++ x64/x86 build tools
       - Windows 10/11 SDK
       - C++ CMake tools
   - Clique em "Install"
   - Aguarde a instalação (pode levar 10-20 minutos)

3. **Reinicie o PowerShell**:
   - Feche e abra novamente o PowerShell
   - Isso carrega as variáveis de ambiente do Visual Studio

4. **Teste novamente**:
   ```powershell
   cd C:\Users\eudenes\Lumene
   npm run tauri:dev
   ```

### Método 2: Visual Studio Community (Alternativa Completa)

Se você prefere instalar o Visual Studio completo:

1. **Baixe Visual Studio Community** (grátis):
   - Acesse: https://visualstudio.microsoft.com/vs/community/
   - Baixe o instalador

2. **Execute o instalador**:
   - Marque a carga de trabalho: **"Desktop development with C++"**
   - Instale

3. **Reinicie o PowerShell** e teste

## Verificação

Após instalar, você pode verificar se o linker está disponível:

```powershell
# Verificar se o Visual Studio está no PATH
where.exe link.exe
```

Ou verificar se o Visual Studio está instalado:

```powershell
# Verificar instalação do Visual Studio
& "C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe" -latest -property installationPath
```

## Configuração do Rust para MSVC

O Rust deve detectar automaticamente o Visual Studio após a instalação. Se ainda não funcionar:

1. **Reinicie o computador** (às vezes necessário para carregar todas as variáveis)

2. **Ou configure manualmente** (geralmente não necessário):
   ```powershell
   # Verificar toolchain
   rustup show
   
   # Se necessário, reinstalar toolchain
   rustup toolchain install stable-x86_64-pc-windows-msvc
   rustup default stable-x86_64-pc-windows-msvc
   ```

## Após Instalação

Depois de instalar o Visual Studio Build Tools:

1. **Feche e reabra o PowerShell** (importante!)

2. **Navegue até o projeto**:
   ```powershell
   cd C:\Users\eudenes\Lumene
   ```

3. **Teste novamente**:
   ```powershell
   npm run tauri:dev
   ```

4. **Aguarde a compilação**:
   - A primeira compilação pode levar 10-30 minutos
   - O Rust está compilando todas as dependências do Tauri
   - Compilações subsequentes serão muito mais rápidas

## Tamanho da Instalação

- **Build Tools**: ~3-6 GB
- **Visual Studio Community**: ~5-10 GB

O Build Tools é suficiente e mais leve.

## Problemas Comuns

### "link.exe not found" mesmo após instalar
- **Solução**: Reinicie o PowerShell ou o computador
- Verifique se marcou "Desktop development with C++" durante a instalação

### Erro de permissão
- Execute o PowerShell como Administrador
- Ou execute o instalador do Visual Studio como Administrador

### Múltiplas versões do Visual Studio
- O Rust usará a versão mais recente automaticamente
- Ou configure manualmente com `rustup default`

## Links Úteis

- Visual Studio Downloads: https://visualstudio.microsoft.com/downloads/
- Build Tools: https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022
- Documentação Rust Windows: https://rust-lang.github.io/rustup/installation/windows.html

## Resumo Rápido

1. Baixe "Build Tools for Visual Studio 2022"
2. Instale com "Desktop development with C++"
3. Reinicie o PowerShell
4. Execute `npm run tauri:dev` novamente

Boa sorte! 🚀



