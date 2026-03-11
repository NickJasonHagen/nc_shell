#nscript installer (compiling from source)
echo copying this dir to ~/nscript, this will be your nscript shared envoirement!
cp -r ./ ~/nscript && cd ~/nscript
echo installing rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
.   "$HOME/.cargo/env"
cd ./setup/nscript && RUSTFLAGS='-C opt-level=3' cargo build --release
#be assured to have the user/bin
#mkdir ~/.local
#mkdir ~/.local/bin
echo copying the executable binary to /bin/nscript
cd ../..
sudo rm /bin/nscript
sudo mv ./setup/nscript/target/release/nscript -u /bin/nscript
sudo chmod +x /bin/nscript
/bin/nscript home/skorm/nscript/setpath.nc
nscript version
echo done
