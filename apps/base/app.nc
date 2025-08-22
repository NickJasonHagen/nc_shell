
thread encryptedbase{
    // func exec(file,filename,xpass){
    //     decr = decrypt(file[1],xpass)
    //     if base64tofile(decr,filename) == "error"{
    //         printraw("error for ","r")}
    //     else{printraw("succes for ","b")}
    //     print(filename)
    //     $ready = "true"        
    // }
    func threadreceive(rec){
        match rec{
            "?" =>{
                return $ready
            }
            "exit" =>{
                $threadname = self
                coroutine "exit" each 10{
                    if $ready == "true"{
                        //print("threaddone!!!!!!!!!!!!!!  ",$threadname,"g")
                        break "coroutine_keepalive"
                    }
                    break self
                }
            }
        }
    }
    $ready = "false"
    printraw("╠","g")
    print("THREAD: starting :",self,"bg")
    decr = decrypt(file[1],xpass)
    if base64tofile(decr,filename) == "error"{
        printraw("╠error for task:","r")
        clr = "r"
        }
    else{
        printraw("╠succes for task:","g")
        clr = "g"
        }
    printraw(cat("[",xcounter,"/",maxlen,"]"),"m")
    printraw(cat(@lf,"╚═══> "),clr)
    print(filename)
    $ready = "true"  

    coroutine "keepalive"{
        sleep(11)
    }
}

class ncbasecontainer{
    func containerizedir(dir,todir){
        containername = terminalinput("name container?","nccontainer.nc")
        xpass = terminalinput("Enter encryption password")
        output = ""
        dir = listdir(dir)
        dirlen = len(dir)
        i = 0
        for xfile in dir{
            if instring(xfile,".") == true && fromleft(xfile,1) != "." && instring(xfile,".ncb") == false{
                fname = cat(dir,xfile)
                print(cat("encrypting job[",i,"/",dirlen,"] ->",fname),"bm")
                base64 = filetobase64(fname)
                output = arraypush(output,cat("#./",encrypt(fname,xpass),@lf,encrypt(base64,xpass)))
                i ++
            }
        }
        //output = encrypt(output,xpass)
        filewrite(cat(todir,"/",containername,".ncb"),join(output,@lf))
        //decrypt(xpass)
    }
    func extractcontainer(){
        subdirname = terminalinput("name container?","nccontainer.nc")
        containername = cat(subdirname,".ncb")
        xpass = terminalinput("Enter encryption password")
        $timer = timerinit()
        decr = fileread(containername)
        runwait(cat("mkdir ",self.ramdisk,"/",subdirname))
        for xfile in split(decr,"#./"){
            file = split(xfile,@lf)
            if len(file) > 1{
                path = replace(cat(self.ramdisk,"/",subdirname,"/",decrypt(file[0],xpass)),"./","")
                if base64tofile(decrypt(file[1],xpass),path) == "error"{
                    printraw("error for ","r")
                }
                else{
                    printraw("succes for ","g")
                }
                print(path)
            }
        }
        print(cat("time:",timerdiff($timer)),"bg")
    }
    func listcontainer(fromdir){
        listarray = arraysearch(listdir(fromdir),".ncb")
        list = string x to subtract(len(listarray),1){
            res = cat("id: [",x," : ",filesize(cat(fromdir,listarray[x])),"]  ",listarray[x],@lf)
            res
        }
        print(list,"by")
        containername = terminalinput("select?")
        printraw("extracting:","bb")
        subdirname = print(replace(listarray[containername],".ncb",""),"br")
        xpass = terminalinput("Enter encryption password")
        $timer = timerinit()
        decr = fileread(cat(fromdir,"/",listarray[containername]))
        xcounter = 0
        $allfiles = split(decr,"#./")
        maxlen = len($allfiles) - 1
        //handler1 = "handler1"
        //request = arraynewsized(4)
        $xthreadvec = arraynew()
        runwait(cat("mkdir ",self.ramdisk,"/",subdirname))
        self.activethreads = 0
        self.maxactivethreads = 12
        spawneri = 0
         coroutine "threadspawner"{
             if ncbasecontainer.maxactivethreads > ncbasecontainer.activethreads{
                for xtask to ncbasecontainer.maxactivethreads{
                    if spawneri <= maxlen{
                        file = split($allfiles[spawneri],@lf)
                        flen = len(file)
                        decname = decrypt(file[0],xpass)
                        //print(decname)
                        if flen > 1{
                            xcounter ++                    
                            filename = cat(ncbasecontainer.ramdisk,"/",subdirname,"/",replace(decname,"./",""))
                            threadname = cat("xthread",xcounter)
                            $xthreadvec = arraypush($xthreadvec,threadname)
                            spawnthread threadname v:file v:filename v:xpass v:xcounter v:maxlen encryptedbase
                            ncbasecontainer.activethreads ++
                            //print("added thread")
                            
                        }
                        if spawneri == maxlen{
                            break self
                        }
                        spawneri ++
                    }
                }             
             }
             else{
                 print(ncbasecontainer.maxactivethreads,"/",ncbasecontainer.activethreads,"bg")
             }
        }
        
        checkvec = arraynewsized(maxlen)
        
        coroutine "check" each 3{
            $okcheck = maxlen
            //sleep(1)
            x = 0
                
            for xthread in $xthreadvec{
                      
                if checkvec[x] != "true" {
                    xt = x + 1
                    tre = cat("xthread",xt)
                    ret = TRD::tre("?")
                    checkvec[x] = ret// arraypush(checkvec,ret)
                    if ret == "true"{
                        //print("thread: ",xthread," checked!","by")
                        ncbasecontainer.activethreads --
                        TRD::tre("exit")
                    }
                    else{
                        //print("thread: ",xthread," not checked!=",ret,"br")
                    }
                }
                x ++ 
            }
            x = 0
            done = true // if any error it be changed
            
            //$veclen = $okcheck
            for xcheck in checkvec{        
                if xcheck != "true" {
                    done = false
                    $okcheck --
                }
                x ++
            }
            if done == true {
                
                print(cat("done! time:",timerdiff($timer)),"g")
                break "coroutine_status"
                break self
                exit
            }
        }
        coroutine "status" each 4999{
            printraw("#status update| ","bm")
            printraw(cat(@lf,"  - elapsed time:",timerdiff($timer)),"by")
            print(cat(@lf,"  - file jobs:[",$okcheck,"/",maxlen,"]"),"by")
            if $okcheck == 0 {break self}

        }

            // for xfile in allfiles{
            //     file = split(xfile,@lf)
            //     flen = len(file)
            //     if flen > 1{
            //         xcounter ++
                    
            //         filename = cat(ncbasecontainer.ramdisk,"/",subdirname,"/",replace(decrypt(file[0],xpass),"./",""))
            //         threadname = cat("xthread",xcounter)
            //         xthreadvec = arraypush(xthreadvec,threadname)
            //         spawnthread threadname v:file v:filename v:xpass v:xcounter v:maxlen encryptedbase
            //     }
            // }

    }
    
    self.ramdisk = "/mnt/ramdisk/test/"
    self.containerdb = "/media/skorm/2TB_Data/ncb/"
}
runwait("mkdir /mnt/ramdisk/test")
print("basecontianer")
 match $cmdarg2{ 
    "pack" =>{
        ncbasecontainer.containerizedir("./",ncbasecontainer.containerdb)
    }
    "unpack" =>{
       ncbasecontainer.extractcontainer() 
    }
    "list" =>{
        if $cmdarg3 == ""{
            ncbasecontainer.listcontainer(ncbasecontainer.containerdb) 
        }
        else{
            ncbasecontainer.listcontainer($cmdarg3)
        }
    }
    _ =>{
        print("unknown command")
    }
}



