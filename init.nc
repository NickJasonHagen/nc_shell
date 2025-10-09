//nscript initscript
class nscript{
    func include(file){
        destfile = cat(@scriptdir,"/include/",file)
        if fileexists(destfile) == false || $cmdarg3 == "update" {
            runwait(cat("mkdir ","./include"))
            print(filecopy(cat(@nscriptpath,"/nclib/",file),destfile))
            print(cat("[Nscript] .nc lib included : ",file,"",$cmdarg3),"by")
        }
        return destfile

    }
    func listinclude(){
        dl = print(httpget(self.mainnet,80,"/listinclude.nc"),"bp")
    }
    self.mainnet = "85.148.230.249"
}
class os{
    func arch(){
        shellcmd = "uname -m"
        self.architechture = runwait(shellcmd)
        return self.architechture[0]
    }
}
class ncapp {
    func construct(){
        self.appdir = cat(@nscriptpath,"/CLI/",self,"/")
    }
    self.appdir = cat(@nscriptpath,"/CLI/",self,"/")
}

class git{
    func clone(url){
        replacebyref(url,"https://github.com/","")
        repo = url
        if instring(url,"/") == false{
            repo = cat("NickJasonHagen/nscript_",url)
        }
        url = cat("https://github.com/",repo)
        reposplit = split(repo,"/")
        dircreate(cat(@nscriptpath,"/git/",reposplit[0]))
        repopath = cat(@nscriptpath,"/git/",reposplit[0],"/",reposplit[1])
        dircreate(repopath)
        print(repopath)
        print(runwait(cat("git clone ",url," ",repopath)))
    }
    func get(url){
         replacebyref(url,"https://github.com/","")
        repo = url
        if instring(url,"/") == false{
            repo = cat("NickJasonHagen/nscript_",url)
        }
        url = cat("https://github.com/",repo)
        reposplit = split(repo,"/")
        dircreate(cat(@nscriptpath,"/git/",reposplit[0]))
        repopath = cat(@nscriptpath,"/git/",reposplit[0],"/",reposplit[1])
        dircreate(repopath)
        print(repopath,"pink")
        print(url,"p")
        print(runwait(cat("git fetch ",url," ",repopath)))       
    }
    func pull(url){
        replacebyref(url,"https://github.com/","")
        repo = url
        if instring(url,"/") == false{
            repo = cat("NickJasonHagen/",url)
        }
        url = cat("https://github.com/",repo)
        reposplit = split(repo,"/")
        dircreate(cat(@nscriptpath,"/git/",reposplit[0]))
        repopath = cat(@nscriptpath,"/git/",reposplit[0],"/",reposplit[1])
        dircreate(repopath)
        tmpbashfile = cat(@nscriptpath,"/tmp.sh")
        print(repopath)
        filewrite(tmpbashfile,cat("cd ",repopath," && git pull"))
        print(runwait(cat("sh ",tmpbashfile)))     
    }
}
func use(repo,update){
    if instring(repo,"/") == false{  
        repo = cat("NickJasonHagen/nscript_",repo)

    }
    
    initscript = cat(@nscriptpath,"/git/",repo,"/init.nc")
    //print("https://raw.githubusercontent.com/",repo,"/refs/heads/main/init.nc","b")
    if fileexists(initscript) == false || update == true{
        reposplit = split(repo,"/")
        dircreate(cat(@nscriptpath,"/git/",reposplit[0]))
        repopath = cat(@nscriptpath,"/git/",reposplit[0],"/",reposplit[1])
        dircreate(repopath)
        runwait(cat("curl https://raw.githubusercontent.com/",repo,"/refs/heads/main/init.nc ","-o ",initscript))
    }
    init initscript
}
func useload(repo,update){
    if instring(repo,"/") == false{  
        repo = cat("NickJasonHagen/nscript_",repo)

    }
    
    initscript = cat(@nscriptpath,"/git/",repo,"/init.nc")
    //print("https://raw.githubusercontent.com/",repo,"/refs/heads/main/init.nc","b")
    if fileexists(initscript) == false || update == true{
        reposplit = split(repo,"/")
        dircreate(cat(@nscriptpath,"/git/",reposplit[0]))
        repopath = cat(@nscriptpath,"/git/",reposplit[0],"/",reposplit[1])
        dircreate(repopath)
        runwait(cat("curl https://raw.githubusercontent.com/",repo,"/refs/heads/main/init.nc ","-o ",initscript))
    }
    return fileread(initscript)
}
$ncshellversion = 1.004
//rint(cat("Running nscript v",@nscriptversion," ncshell:",$ncshellversion," builtin:functions:",len(nscript::getrustfunctions())))
check = $cmdarg1
iets = match check{
    "testgit" =>{
        use("server")
    }
    "run" =>{
        init $cmdarg2
    }
    "version" =>{
        printraw("NCshell version:","by")

        print($ncshellversion,"bg")
        printraw("Nscript version:","by")
        print(@nscriptversion,"green")
    }
    "conf" =>{
        run(cat("code ",@nscriptpath))
    }
    _ =>{
        appfile = cat(@nscriptpath,"/CLI/",$cmdarg1,"/app.nc")
        $arg3 = $cmdarg3
        init appfile
    }
}

//print("done!")
