@echo off
(
  echo Copying this directory to ~\nscript, this will be your \nscript shared environment!
  copy /r ./ %USERPROFILE%\~\nscript
  echo Installing rust
  powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://sh.rustup.rs', '%TEMP%\%~n rustup-init.ps1')" && powershell -Command "rustup init"
  cd /d %USERPROFILE%\~\nscript
  echo Building nscript with cargo
  RUSTFLAGS=-C opt-level=3 cargo build --release
  mkdir %USERPROFILE%\.local
  mkdir %USERPROFILE%\.local\bin
  echo Copying the executable binary to %USERPROFILE%\.local\bin\nscript.exe
  cd ..\..
  del /f %USERPROFILE%\.local\bin\nscript.exe
  move ..\..\setup\nscript\target\release\nscript.exe %USERPROFILE%\.local\bin\nscript.exe
) > ninstall.bat