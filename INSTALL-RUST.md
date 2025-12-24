# Instalando Rust no Windows

O Rust é necessário para o Tauri compilar o aplicativo desktop. Siga estes passos:

## Método 1: Instalação Direta (Recomendado)

1. **Baixe o Rustup**:
   - Acesse: https://rustup.rs/
   - Clique em "DOWNLOAD RUSTUP-INIT.EXE (64-BIT)" para Windows
   - Ou use este link direto: https://win.rustup.rs/x86_64

2. **Execute o instalador**:
   - Execute o arquivo `rustup-init.exe` baixado
   - Pressione **Enter** para continuar com a instalação padrão
   - O instalador irá:
     - Baixar e instalar o Rust
     - Adicionar ao PATH automaticamente
     - Instalar o `rustc` (compilador) e `cargo` (gerenciador de pacotes)

3. **Reinicie o PowerShell/Terminal**:
   - **IMPORTANTE**: Feche e abra novamente o PowerShell
   - Isso é necessário para carregar as variáveis de ambiente atualizadas

4. **Verifique a instalação**:
   ```powershell
   rustc --version
   cargo --version
   ```

   Você deve ver algo como:
   ```
   rustc 1.75.0 (ou versão mais recente)
   cargo 1.75.0 (ou versão mais recente)
   ```

## Método 2: Usando Chocolatey (Se você tem Chocolatey instalado)

```powershell
choco install rust
```

Depois, reinicie o PowerShell.

## Método 3: Usando Winget (Windows 10/11)

```powershell
winget install Rustlang.Rustup
```

Depois, reinicie o PowerShell.

## Verificação Completa

Após instalar o Rust, verifique se tudo está funcionando:

```powershell
# Verificar Rust
rustc --version
cargo --version

# Verificar Node.js (também necessário)
node --version
npm --version
```

## Próximos Passos

Depois de instalar o Rust e reiniciar o PowerShell:

1. **Navegue até o projeto**:
   ```powershell
   cd C:\Users\eudenes\Lumene
   ```

2. **Instale as dependências do Node.js** (se ainda não fez):
   ```powershell
   npm install
   ```

3. **Teste o projeto**:
   ```powershell
   npm run tauri:dev
   ```

## Problemas Comuns

### "rustc não é reconhecido" após instalação
- **Solução**: Feche e reabra o PowerShell/Terminal
- Se ainda não funcionar, reinicie o computador
- Verifique se o PATH contém: `C:\Users\SeuUsuario\.cargo\bin`

### Erro durante instalação
- Certifique-se de ter conexão com a internet
- O instalador precisa baixar vários componentes (pode levar alguns minutos)
- Se falhar, tente executar como Administrador

### Visual Studio Build Tools necessário
- O Rust no Windows requer as ferramentas de build do Visual Studio
- Se você ainda não tem, instale:
  - Visual Studio Build Tools: https://visualstudio.microsoft.com/downloads/
  - Ou Visual Studio 2019+ com "Desktop development with C++"
  - O instalador do Rust geralmente detecta e oferece para instalar automaticamente

## Links Úteis

- Rust: https://www.rust-lang.org/
- Rustup: https://rustup.rs/
- Documentação Rust: https://doc.rust-lang.org/
- Tauri Docs: https://tauri.app/

## Nota Importante

A primeira vez que você executar `npm run tauri:dev` ou `npm run tauri:build`, o Rust irá:
- Compilar todas as dependências do Tauri
- Isso pode levar **10-30 minutos** na primeira vez
- Compilações subsequentes serão muito mais rápidas

Seja paciente na primeira compilação! ☕




