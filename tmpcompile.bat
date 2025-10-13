cd "#COMPILEPATH#"
cargo build --release
move "#COMPILEPATH#\target\release\#APP#.exe" "#SCRIPTDIR#\#APP#.exe"
