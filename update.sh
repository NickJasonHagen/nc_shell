cd ./setup/nscript && cargo update && RUSTFLAGS='-C opt-level=3' cargo build --release
mkdir ~/.local/bin
echo copying the executable binary to ~/.local/bin/nscript 
cd ../..
sudo rm /usr/local/bin/nscript 
sudo mv ./setup/nscript/target/release/nscript -u /usr/local/bin/nscript 
sudo chmod +x /usr/local/bin/nscript
nscript version
echo "all done !  ---> (continue = control + c )"
exit

