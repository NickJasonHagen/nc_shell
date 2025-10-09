if $cmdarg2 == ""{
    $packagename = terminalinput("package name?","mynscriptproject")
}
else{
    $packagename = $cmdarg2
}

// print("created project dir:",$cmdarg2,"")
// dircreate($cmdarg2)
// copy the code highlighting for .nc files
runwait(cat("mkdir ",".vscode"))
filecopy(
    cat(
        @nscriptpath,
        "/.vscode/settings.json"
    ),
    cat(
        @scriptdir,
        ".vscode/settings.json"
    )
)
//deprecated! 
// if fileexists(cat(@scriptdir,"/nclib.nc")) == false{
//     filecopy(
//         cat(@nscriptpath,"/nclib/nclib.nc"),
//         cat(@scriptdir,"/nclib.nc")
//     )
// }
packstr = #raw
    
    class package{

        self.name = "#PKGNAME#"
        self.includes = [
            "init.nc"
        ]
        //array for git rep use
        self.use = []
    }
#endraw
replacebyref(packstr,"#PKGNAME#",$packagename)
pkfile = cat(@scriptdir,"/package.nc")

if fileexists(pkfile) == false || $cmdarg3 = "force"{
    print("created a package.nc file.")
    filewrite(pkfile,packstr)
}
else{
    print("package exists! see package.nc","r")
}
initfile = cat(@scriptdir,"/init.nc")
if fileexists(initfile) == false{
    print("created a init.nc file.")
    filewrite(initfile,"print(\"helloworld!\")")
}
else{
    print("init.nc exists! ready.","g")
}
// 
// njh::save("//![nscript init]",cat("init ",@quote,"nclib.nc",@quote),cat(@scriptdir,"/init.nc"))
// scriptdata = fileread(cat(@nscriptpath,"/nclib/nclib.nc"))
// scriptdata = replace(scriptdata,"#PACKAGENAME#",$cmdarg2)
// filewrite(cat(@scriptdir,"/nclib.nc"),scriptdata)
// opentext = cat "installed -------" @e_okhand @e_smile @lf "Choose a option" @lf "1: Open Vsc and begin" @e_cowboy @e_cash @lf "2: nah im done for now back to terminal " @e_salute @lf
// if terminalinput(opentext,1) == 1 {
//     run("code .")
// }