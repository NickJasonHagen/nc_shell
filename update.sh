cd ./setup/nscript && cargo update && RUSTFLAGS='-C opt-level=3' cargo build --release
mkdir ~/.local/bin
echo copying the executable binary to ~/.local/bin/nscript 
cd ../..
rm ~/.local/bin/nscript 
mv ./setup/nscript/target/release/nscript -u ~/.local/bin/nscript 
chmod +x ~/.local/bin/nscript
nscript version
echo "all done !  ---> (continue = control + c )"
exit

