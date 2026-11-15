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
echo copying the executable binary to /usr/local/bin/nscript
cd ../..
sudo rm /usr/localbin/nscript
sudo mv ./setup/nscript/target/release/nscript -u /usr/local/bin/nscript
sudo chmod +x /usr/local/bin/nscript
/usr/local/bin/nscript home/$USER/nscript/setpath.nc
nscript version
echo done
