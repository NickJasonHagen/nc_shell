class ipaddress{
    func list(){
        if @OS == "Unix" {
            ipcmd = split(runwait("ifconfig"),"inet ")
            ret = ""
            i = 0
            for xip in ipcmd{
                subip = splitselect(xip," netmask",0)
                print(cat("ip:[",i,"] ",subip))
                i ++
                ret = arraypush(ret,subip)
            }
            return ret
        }
        else{
            print("function not yet made on windows")
        }
    }
}