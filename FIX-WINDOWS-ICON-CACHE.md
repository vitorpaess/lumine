# Fix: Cache de Ícones do Windows

O problema não é com o build - os ícones estão corretos! O Windows está usando cache antigo.

## 🔍 Por Que Isso Acontece?

Quando você move para a lixeira e o ícone aparece correto, isso confirma que:
- ✅ Os ícones no executável estão corretos
- ❌ O Windows está usando cache antigo na área de trabalho/Menu Iniciar

## 🔧 Soluções

### Solução 1: Limpar Cache de Ícones do Windows (Recomendado)

1. **Feche todos os programas** (especialmente o seu app se estiver aberto)

2. **Abra o PowerShell como Administrador**:
   - Pressione `Win + X`
   - Escolha "Windows PowerShell (Admin)" ou "Terminal (Admin)"

3. **Execute estes comandos**:
   ```powershell
   # Parar o processo de cache de ícones
   taskkill /f /im explorer.exe
   
   # Limpar cache de ícones
   Remove-Item "$env:LOCALAPPDATA\IconCache.db" -ErrorAction SilentlyContinue
   Remove-Item "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\iconcache*" -Recurse -Force -ErrorAction SilentlyContinue
   
   # Reiniciar o Explorer
   Start-Process explorer.exe
   ```

4. **Aguarde alguns segundos** para o Windows reconstruir o cache

5. **Atualize a área de trabalho**: Pressione `F5` ou clique direito → Atualizar

### Solução 2: Reconstruir Cache Manualmente

1. **Feche o aplicativo** se estiver aberto

2. **Abra o PowerShell como Administrador**

3. **Execute**:
   ```powershell
   ie4uinit.exe -show
   ```

4. **Aguarde** alguns segundos

5. **Atualize a área de trabalho** (F5)

### Solução 3: Desinstalar e Reinstalar

1. **Desinstale o aplicativo** completamente:
   - Painel de Controle → Programas → Desinstalar
   - Ou use: `appwiz.cpl`

2. **Limpe o cache** (Solução 1)

3. **Reinstale** o novo `.exe`

### Solução 4: Forçar Atualização do Ícone

1. **Clique direito** no atalho na área de trabalho

2. **Propriedades** → **Alterar Ícone**

3. **Navegue até** o executável:
   ```
   C:\Program Files\Lumene\Lumene.exe
   ```
   (ou onde você instalou)

4. **Selecione** o executável e clique OK

5. **Aplique** as mudanças

## 🎯 Método Rápido (Mais Simples)

1. **Desinstale** o aplicativo antigo
2. **Reinicie** o computador (isso limpa o cache)
3. **Instale** o novo `.exe`

## ✅ Verificação

Após limpar o cache:

1. **Procure o aplicativo** no Menu Iniciar
2. **Verifique o ícone** na área de trabalho (se tiver atalho)
3. **Verifique o ícone** na barra de tarefas (se estiver fixado)

Todos devem mostrar o novo ícone!

## 💡 Dica

Se você criar um novo atalho após limpar o cache, ele usará o ícone correto automaticamente.

## 🔍 Verificar se o Ícone Está Correto no Executável

Para confirmar que o ícone está correto no `.exe`:

1. **Navegue até** o executável:
   ```
   src-tauri\target\release\Lumene.exe
   ```

2. **Clique direito** → **Propriedades** → **Aba "Geral"**

3. **Verifique o ícone** mostrado no topo da janela de propriedades

Se estiver correto aqui, o problema é definitivamente cache do Windows!

