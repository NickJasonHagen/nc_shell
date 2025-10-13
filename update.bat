@echo off
(
  cd /d %USERPROFILE%\~\nscript
  echo Building nscript with cargo
  cargo update
  RUSTFLAGS=-C opt-level=3 cargo build --release
  mkdir %USERPROFILE%\.local
  mkdir %USERPROFILE%\.local\bin
  echo Copying the executable binary to %USERPROFILE%\.local\bin\nscript.exe
  cd ..\..
  del /f %USERPROFILE%\.local\bin\nscript.exe
  move ..\..\setup\nscript\target\release\nscript.exe %USERPROFILE%\.local\bin\nscript.exe
) > ninstall.bat
