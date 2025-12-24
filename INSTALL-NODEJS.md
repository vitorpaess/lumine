# Instalando Node.js no Windows

O Node.js é necessário para executar o Tauri. Siga estes passos:

## Método 1: Instalação Direta (Recomendado)

1. **Baixe o Node.js**:
   - Acesse: https://nodejs.org/
   - Baixe a versão **LTS** (Long Term Support) - recomendada
   - Escolha o instalador Windows (.msi)

2. **Execute o instalador**:
   - Execute o arquivo `.msi` baixado
   - Siga o assistente de instalação
   - **Importante**: Marque a opção "Add to PATH" durante a instalação
   - Complete a instalação

3. **Reinicie o PowerShell/Terminal**:
   - Feche e abra novamente o PowerShell ou terminal
   - Isso é necessário para carregar as variáveis de ambiente atualizadas

4. **Verifique a instalação**:
   ```powershell
   node --version
   npm --version
   ```

## Método 2: Usando Chocolatey (Se você tem Chocolatey instalado)

```powershell
choco install nodejs-lts
```

## Método 3: Usando Winget (Windows 10/11)

```powershell
winget install OpenJS.NodeJS.LTS
```

## Após a Instalação

Depois de instalar o Node.js:

1. **Feche e reabra o PowerShell**
2. **Navegue até o diretório do projeto**:
   ```powershell
   cd C:\Users\eudenes\Lumene
   ```

3. **Instale as dependências**:
   ```powershell
   npm install
   ```

4. **Instale o Rust** (se ainda não tiver):
   - Acesse: https://rustup.rs/
   - Baixe e execute `rustup-init.exe`
   - Siga as instruções

5. **Teste o projeto**:
   ```powershell
   npm run tauri:dev
   ```

## Verificação Rápida

Execute estes comandos para verificar se tudo está instalado:

```powershell
node --version    # Deve mostrar algo como v20.x.x
npm --version     # Deve mostrar algo como 10.x.x
rustc --version   # Deve mostrar a versão do Rust
```

## Problemas Comuns

### "npm não é reconhecido" após instalação
- **Solução**: Feche e reabra o PowerShell/Terminal
- Se ainda não funcionar, reinicie o computador

### Node.js instalado mas não no PATH
- Reinstale o Node.js e certifique-se de marcar "Add to PATH"
- Ou adicione manualmente ao PATH do Windows

### Versão antiga do Node.js
- Tauri requer Node.js v16 ou superior
- Atualize para a versão LTS mais recente

## Links Úteis

- Node.js: https://nodejs.org/
- Rust: https://rustup.rs/
- Tauri Docs: https://tauri.app/
