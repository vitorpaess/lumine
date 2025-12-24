fn main() {
  // Include custom NSIS hooks if they exist
  let hooks_path = std::path::Path::new("windows/hooks.nsh");
  if hooks_path.exists() {
    println!("cargo:rerun-if-changed=windows/hooks.nsh");
  }
  
  tauri_build::build()
}

