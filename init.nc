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
        return self.architechture
    }
    self.architechture = runwait("uname -m")
}
class ncapp {
    func construct(){
        self.appdir = cat(@nscriptpath,"/apps/",self,"/")
    }
    self.appdir = cat(@nscriptpath,"/apps/",self,"/")
}
$ncshellversion = 1.003
print(cat("Running nscript v",@nscriptversion," ncshell:",$ncshellversion," builtin:functions:",len(nscript::getrustfunctions())))
check = $cmdarg1
iets = match check{

    "run" =>{
        init $cmdarg2
    }
    "piet" =>{
        print("haaaalo piet!!!!")
    }
    "runline" =>{
        print(nscript::rawcode(terminalinput("codeline?","")))
    }
    "hotcommand" =>{
        run(cat("nscript ",terminalinput("nc commando:","version")))
    }
    "helpraw" =>{
        functions = nscript::getrustfunctions()
        explanation = nscript::getrustfunctionshelp()
        max = len(functions) - 1
        for x to max{
            print(functions[x],"g")
            print(cat(functions[x],"",explanation[x]),"bb")
        }
    }
    "help" =>{
        functions = nscript::getrustfunctions()
        explanation = nscript::getrustfunctionshelp()
        max = len(functions) - 1
        stringvec = ""
        for x to max{
            stringvec &= cat(" corefunc ",functions[x],"",explanation[x],@lf)
        }
        words = split(stringvec," ")
        doing = "func"
        xid = 0
        for xword in words{
            if xword == "corefunc"{
                doing = "func"
                printraw(cat("fn-id:",xid," | "),"p")
                xid ++
            }
            if xword == "//"{
                doing = "comment"
            }
            if xword != "corefunc" {
                if doing = "func"{
                    if instring(xword,"(") == true{
                        splitf = split(xword,"(")
                        printraw(splitf[0],"bb")
                        printraw("(","by")
                        argsplit = split(splitselect(splitf[1],")",0),",")
                        i = 0
                        max = len(argsplit)
                        for xarg in argsplit{
                            i ++
                            printraw(xarg,"p") 
                            if i < max {
                                printraw(",","by")
                            }
                        }
                        printraw(")","by")
                    }
                }
                else{
                    printraw(xword,"g")
                }
            }
            printraw(" ")
        }
    }
    "init" =>{

        if $cmdarg2 == ""{
            $cmdarg2 = terminalinput("package name?","mynscriptproject")
        }

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
        if fileexists(cat(@scriptdir,"/nclib.nc")) == false{
            filecopy(
                cat(@nscriptpath,"/nclib/nclib.nc"),
                cat(@scriptdir,"/nclib.nc")
            )
        }
        njh::save("//![nscript init]",cat("init ",@quote,"nclib.nc",@quote),cat(@scriptdir,"/init.nc"))
        scriptdata = fileread(cat(@nscriptpath,"/nclib/nclib.nc"))
        scriptdata = replace(scriptdata,"#PACKAGENAME#",$cmdarg2)
        filewrite(cat(@scriptdir,"/nclib.nc"),scriptdata)
        opentext = cat "installed -------" @e_okhand @e_smile @lf "Choose a option" @lf "1: Open Vsc and begin" @e_cowboy @e_cash @lf "2: nah im done for now back to terminal " @e_salute @lf
        if terminalinput(opentext,1) == 1 {
            run("code .")
        }
    }
    "set" =>{
        if $cmdarg2 == "vsc-config"{
        runwait(cat("mkdir ",@scriptdir,"/.vscode"))
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
        }
    }
    "test" =>{
        print(
            cat( // print the msg
                "version:",@nscriptversion,
                " ncshell:",$ncshellversion,
                @e_cash
            ),
            "br" // printing color
        ) 
        a = "print"
        *a("elllooooo")
    }
    "version" =>{
        print(cat("NCshell version:",$ncshellversion),"bg")
        print(@nscriptversion)
    }
    "webserver" =>{
        
        init cat(@nscriptpath,"/nclib/webserver.nc")
        server.listpublicfiles()
    }
    "conf" =>{
        run(cat("code ",@nscriptpath))
    }
    _ =>{
        appfile = cat(@nscriptpath,"/apps/",$cmdarg1,"/app.nc")
        //appfile !
        $arg3 = $cmdarg3
        init appfile
        //print("derping")
    }
}

//print("done!")
