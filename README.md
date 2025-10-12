# Nscript envoirement shell
this is the nscript shared envoirement dir.<br>
By default its ~/nscript and its linked to @nscriptpath inside the language itself.<br>
you can change your path from your profile/bash/zsh.
```bash
export NSCRIPT_PATH=/your/path
```
The @nscriptpath macro in nscript links to this env var.

## what does it do?
The envoirement is used for various CLI tools.<br>
In your binary you can execute the /init.nc from your envoirement while remaining in your workingdir.<br>
in this project we use the ~/nscript/init.nc to enable our scripts from the CLI folder.<br>
for example you can see how the envoirement handles commands like "nscript init" and "nscript compile".<br>
the entree begins at init.nc and from there it will continue to CLI by the given argument logic.
<br><br>
### cli examples
```bash
# creates a new project will ask you a projectname
nscript init
# run a script (no compile)
nscript run ./somescript.nc
# compile a script into a single binary (unix only)
nscript compile
```
## Examples and source
for examples on nscript ( and integrating nscript into your rust project) see:
- https://github.com/NickJasonHagen/nscriptv3_bin
for the sourcecode of the nscript interpreter see
- https://github.com/NickJasonHagen/nscriptv3_lib
## Compiler
WIP:currently only working for Linux (unix)<br><br>
Nscript is a runtime interpreted script engine built in Rust.<br>
Because of this i choose to use the rust compiler instead.<br>
In order to compile you will actually need to have Rust installed.<br>
You wont need to know any Rust so no worries! just have it installed and you are good to go!<br><br>

In the ~/nscript folder theres a nscript_compile dir, which is a template in Rust holding the core version of the Nscript runtime.<br>
The compiling method uses this folder to build the binary with the scripts embedded. then extract the binary from the project and move it to your current workingdir.<br>
And it will perform a "chmod +x" to make it executeable.
## depandancies
new: <br>
all the depandancies are handled by git repo's<br>
they get stored into the ~/nscript/git folder on the authers subdir/project.<br>
in the ~/nscript/init.nc theres the func use() which handles these!

<br>
deprecated<br>
as nscript is still in development before the git system was in, it used nclib to hold shared scripts. this will be going out sometime.


### Contact ?
Like to get in touch ? 
find me on discord @skormaka
