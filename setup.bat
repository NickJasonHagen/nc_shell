
  echo Copying this directory to ~\nscript, this will be your \nscript shared environment!
  copy /r ./ %USERPROFILE%\nscript
  cd /d %USERPROFILE%\~\nscript
  echo Building nscript with cargo
  cargo build --release
  mkdir %USERPROFILE%\programs
  echo Copying the executable binary to %USERPROFILE%\programs\nscript.exe
  cd ..\..
  del /f %USERPROFILE%\programs\nscript.exe
  move ..\..\setup\nscript\target\release\nscript.exe %USERPROFILE%\programs\nscript.exe
  setx  NSCRIPT_PATH=%USERPROFILE%\nscript\
