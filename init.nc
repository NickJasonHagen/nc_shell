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
    func cpu(){
        res = runwait("lscpu | grep 'Model name' | cut -d: -f2 | sed 's/^ //'   ")
        return trim(res[0])
    }
}

class ncapp {
    func construct(){
        self.appdir = cat(@nscriptpath,"/CLI/",self,"/")
    }
    self.appdir = cat(@nscriptpath,"/CLI/",self,"/")
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
}
func use(repo,update){
    loadrepo(repo,updat)
    initscript = cat(@nscriptpath,"/git/",repo,"/init.nc")
    init initscript
}
func install(repo){
    res = loadrepo(repo,true)
    print("installing nscript repo: ",repo,"by")
    print(res[1])
}
$ncshellversion = 1.004 
match $cmdarg1{
    "install" =>{
        install($cmdarg2)
    }
    "update" =>{
        if $cmdarg2 != "-y"{
            check_repo = terminalinput("Update nscript dep repositories? y/n","n")
            check_binary = terminalinput("Update Nscript runtime binary? y/n","n")
        }
        if check_repo == "y" || $cmdarg2 == "-y"{
            print("_______________[Nscript updater]_______________")
            for xdir in listdir(cat(@nscriptpath,"/git/")){
                print("__[checking gitrepos for user ",xdir,"]__","bg")
                for xrepo in listdir(cat(@nscriptpath,"/git/",xdir)){
                    thisrepo = cat(xdir,xrepo)
                    
                    print("[Checking update] git:",thisrepo,"y")
                    initscript = cat(@nscriptpath,"/git/",thisrepo,"/init.nc")
                    gitinitscript = cat(@nscriptpath,"/git/",thisrepo,"/gitinit.nc")
                    runwait(cat("curl https://raw.githubusercontent.com/",thisrepo,"/refs/heads/main/init.nc ","-o ",gitinitscript))
                    readload = fileread(gitinitscript)
                    if readload == "404: Not Found"{
                        print("[Error] repo not found!","r")
                    }
                    else{
                        if readload != "" && len(split(readload,@lf)) > 1{
                            if readload != fileread(initscript){
                                print("[Updated]","g")
                                filewrite(initscript,readload)
                            }
                            
                        }
                    }
                    filedelete(gitinitscript)

                }
            }
        }
        else{
            print("Repos not updated.")
        }
        if check_binary == "y" || $cmdarg2 == "-y"{
            run(cat("cd ",@nscriptpath," && sh ./update.sh"))
        }
        else{
            print("Binary not updated.")
        }
        
    }
        
    "run" =>{
        init $cmdarg2
    }
    "version" =>{
        print("Nscript version:",@nscriptversion,@lf," ncshell:",$ncshellversion,@lf," builtin:Rustfunctions:",len(nscript::getrustfunctions()),"by")
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
