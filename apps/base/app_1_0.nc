
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
        return $ready
    }
    $ready = "false"
    print(cat("THREAD: starting :",self," w:",xpass),"bb")
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

    coroutine "keep alive"{
        sleep(1)
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
        allfiles = split(decr,"#./")
        maxlen = len(allfiles) - 1
        handler1 = "handler1"
        request = arraynewsized(4)
        threadvec = arraynew()
        runwait(cat("mkdir ",self.ramdisk,"/",subdirname))
        for xfile in allfiles{
            file = split(xfile,@lf)
            flen = len(file)
            if flen > 1{
                xcounter ++
                
                filename = cat(self.ramdisk,"/",subdirname,"/",replace(decrypt(file[0],xpass),"./",""))
                threadname = cat("xthread",xcounter)
                threadvec = arraypush(threadvec,threadname)
                spawnthread threadname v:file v:filename v:xpass v:xcounter v:maxlen encryptedbase
            }
        }
        
        coroutine "check"{
            //sleep(1)
            x = 0
            checkvec = arraynew()       
            for xthread in threadvec{
                x ++       
                tre = cat("xthread",x)
                ret = TRD::tre("?")
                checkvec = arraypush(checkvec,ret)
            }
            x = 0
            done = true // if any error it be changed
            $okcheck = len(checkvec)
            $veclen = $okcheck
            for xcheck in checkvec{        
                if *xcheck != true {
                    done = false
                    $okcheck --
                }
                x ++
            }
            if done == true {
                print(cat("done! time:",timerdiff($timer)),"g")
                break "coroutine_status"
                break self
            }
        }
        coroutine "status" each 4999{
            printraw("#status update| ","bm")
            printraw(cat(@lf,"  - elapsed time:",timerdiff($timer)),"by")
            print(cat(@lf,"  - file jobs:[",$okcheck,"/",$veclen,"]"),"by")
            if $okcheck == $veclen {break self}

        }
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



print("jaja dit werkt nu ook gewoon !","rgb(190, 206, 46)")