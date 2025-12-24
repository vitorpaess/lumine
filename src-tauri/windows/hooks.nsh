; Custom NSIS hooks to control shortcuts
; This file overrides Tauri's default shortcut creation
; Place this file in src-tauri/windows/hooks.nsh

; Override CreateDesktopShortcut function to prevent duplicates and uninstaller shortcut
Function CreateDesktopShortcut
  ; Remove any existing shortcuts first to avoid duplicates
  Delete "$DESKTOP\Lumene.lnk"
  Delete "$DESKTOP\uninstall.lnk"
  
  ; Create only ONE desktop shortcut for the app
  CreateShortcut "$DESKTOP\Lumene.lnk" "$INSTDIR\Lumene.exe"
  
  ; Do NOT create uninstaller shortcut on desktop
  ; The uninstaller is still available in Control Panel (appwiz.cpl)
FunctionEnd

; Keep the start menu shortcut as is (it's fine)
; Function CreateStartMenuShortcut is not overridden

; Custom uninstall cleanup
Function un.onUninstSuccess
  ; Remove shortcuts on uninstall
  Delete "$DESKTOP\Lumene.lnk"
  Delete "$DESKTOP\uninstall.lnk"
FunctionEnd

