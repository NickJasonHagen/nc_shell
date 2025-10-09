#nscript installer (compiling from source)

echo installing rust
#curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cd ./setup/nscript && RUSTFLAGS='-C opt-level=3' cargo build --release
mkdir ~/.local/bin
echo copying the executable binary to ~/.local/bin/nscript 
cd ../..
rm ~/.local/bin/nscript 
mv ./setup/nscript/target/release/nscript -u ~/.local/bin/nscript 
chmod +x ~/.local/bin/nscript

echo done
