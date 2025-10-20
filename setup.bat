  echo nscript requires windows users to have Rust (cargo) installed, 
  echo with shell you need to use setx NSCRIPT_PATH=%USERPROFILE%\nscript\ if "nscrip version" doesnt show a version.
  cd /d %USERPROFILE%\nscript
  echo Building nscript with cargo
  cargo build --release
  mkdir %USERPROFILE%\programs
  echo Copying the executable binary to %USERPROFILE%\programs\nscript.exe
  cd ..\..
  del /f %USERPROFILE%\programs\nscript.exe
  move ..\..\setup\nscript\target\release\nscript.exe %USERPROFILE%\programs\nscript.exe
  setx  NSCRIPT_PATH=%USERPROFILE%\nscript\
