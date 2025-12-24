# Migração para Tauri v2

## 🎯 Por Que Migrar?

O Tauri v2 tem suporte nativo para desabilitar atalhos:
```json
"nsis": {
  "shortcut": false
}
```

Isso é muito mais simples do que usar scripts de patch!

## 📋 Passos da Migração

### 1. Atualizar Dependências Node.js

```json
{
  "dependencies": {
    "@tauri-apps/api": "^2.0.0"
  },
  "devDependencies": {
    "@tauri-apps/cli": "^2.0.0"
  }
}
```

### 2. Atualizar Cargo.toml

```toml
[build-dependencies]
tauri-build = { version = "2.0", features = [] }

[dependencies]
tauri = { version = "2.0", features = ["shell-open", "http-all"] }
```

### 3. Atualizar tauri.conf.json

A estrutura do v2 é diferente. Veja o arquivo atualizado abaixo.

### 4. Atualizar main.rs

O código Rust precisa de pequenos ajustes.

## ⚠️ Nota

O Tauri v2 ainda está em beta/RC, mas já é estável o suficiente para uso. Se preferir estabilidade máxima, pode continuar com v1 e usar o patch.

