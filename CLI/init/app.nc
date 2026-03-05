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
    func load(){
        for xscript in self.includes{
            if xscript != "init.nc"{
                init xscript
            }
        } 
        for xrepo in self.use{
                self.use(xrepo,false)
        }
        return "loaded!"
    }
    func loadrepo(repo,update){
        if instring(repo,"/") == false{
            repo = cat("NickJasonHagen/nscript_",repo)
        }

        initscript = cat(@nscriptpath,"/git/",repo,"/init.nc")
        if fileexists(initscript) == false || update == true{
            reposplit = split(repo,"/")
            dircreate(cat(@nscriptpath,"/git/",reposplit[0]))
            repopath = cat(@nscriptpath,"/git/",reposplit[0],"/",reposplit[1])
            dircreate(repopath)
            if @OS == "Unix"{
                return runwait(cat("curl https://raw.githubusercontent.com/",repo,"/refs/heads/main/init.nc ","-o ",initscript))
            }
            else{
                return runwait(cat("curl.exe https://raw.githubusercontent.com/",repo,"/refs/heads/main/init.nc ","-o ",initscript))
            }
        }
        repo
    }
    func use(repo,update){
        repo = self.loadrepo(repo,update)
        initscript = cat(@nscriptpath,"/git/",repo,"/init.nc")
        init initscript
        initscript
    }
    // compiler/runtime:
    // all .includes and .use will be included in the binary upon compilation. 
    self.name = "testnc"
    // will be included on compilation
    // add your project includes here 
    self.includes = [
        "init.nc"
    ]
    //array for git rep use, will also be included in compilation
    // gituser/nscript_reponame
    //(if no slash is given, it will automaticly forward it to git:nickjasonhagen/nscript_GIVENREPO)
    self.use = [
        ""
    ]
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
    initscript = #raw
    class runtime{
        if fileexists("package.nc") == true{
            nscript::parsefile("package.nc")
            package.load()
        }
    }
    print("helloworld","green")
    #endraw
    filewrite(initfile,initscript)
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