func useload(repo,update){
    if instring(repo,"/") == false{
        repo = cat("NickJasonHagen/nscript_",repo)
    }

    initscript = cat(@nscriptpath,"/git/",repo,"/init.nc")
    if fileexists(initscript) == false || update == true{
        reposplit = split(repo,"/")
        dircreate(cat(@nscriptpath,"/git/",reposplit[0]))
        repopath = cat(@nscriptpath,"/git/",reposplit[0],"/",reposplit[1])
        dircreate(repopath)
        runwait(cat("curl https://raw.githubusercontent.com/",repo,"/refs/heads/main/init.nc ","-o ",initscript))
    }
    return fileread(initscript)
}
if $cmdarg2 == "update"{
    update = true
}
else{
    update = false
}
timer = timerinit()
// read the package for meta
init "./package.nc"
projectname = package.name

$compilerdir = cat(@nscriptpath,"/nscript_compiler/")
//projectname = terminalinput("Projectname:","nscriptapp")
printraw("[Nscript compiler]","b")
print("Reading nscript.package name : ",projectname,"pink")
mainrs = cat($compilerdir,"src/main.rs")
mainrsraw = cat($compilerdir,"src/main_raw.rs")
myscriptdata = ""
for xinclude in package.use{
    printraw("[Nscript builder]","m")
    print("Reading nscript.package use-file: ",xinclude,"pink")
    myscriptdata &= @lf useload(xinclude,update)
}
if len(package.includes) > 0{
    for xinclude in package.includes{
        printraw("[Nscript builder]","m")
        print("Reading nscript.package include-file: ",xinclude,"pink")
        myscriptdata &= @lf fileread(cat(@scriptdir,xinclude))
    }
}


sourcedata = fileread(mainrsraw)

printraw("[Nscript builder]","m")
print("Building project : ",projectname,"pink")
cargofileraw = cat($compilerdir,"CargoRaw.toml")
cargofile = cat($compilerdir,"Cargo.toml")
replacebyref(sourcedata,"#NSCRIPTHEXCODE#",stringtohex(myscriptdata))
cargodata = fileread(cargofileraw)
replacebyref(cargodata,"#NAME#",projectname)
filewrite(cargofile,cargodata)
filewrite(mainrs,sourcedata)

printraw("[Rust Compiler]","bb")
print("Start compiling the rust binary","pink")
path = runwait("pwd")
cline = cat(
    "cd ",$compilerdir,
    " && RUSTFLAGS='-C opt-level=3' cargo build --release",
    " && mv ",$compilerdir,"target/release/",projectname,
    " ",path[0],"/",projectname,
    " && cd ",path[0],"/",projectname,
    "&& chmod +x ./",projectname
)

//print(cline,"bb")
res = runwait(cline)
if instring(res,"Finished `release") == true{
    printraw("[Nscript Compiler]","b")
    print("compiling succesfull!","g")
    print("Executable file saved ./",projectname,"bg")
    timed = timerdiff(timer) / 1000
    print("[Finished] time : ",timed,"sec","")
}
else{
    printraw("[Nscript Compiler]","b")
    print("Compiling error! logs:","r")
    print(res[1],"bb")
    print("[Error] cannot compile, see logs","r")
}

//cleanup
filedelete(cat($compilerdir,"target/release/",projectname,".d"))
