//server
class server{
    // internally called by the runtime when a new client connects from http::listen(socket)
    // kick connection by return false
    // you can redeclare it later under server class
    func onconnect(clientIP){
        $userip = cat("ip:",clientIP)
        print($userip,"g")
        print($domainname,"y") // prints the users reached by dns
        print($request,"grey") // prints the users reached by dns
        // if $param1 == "testdc"{
        //     return false
        // }
    }
    // postdata handler for non json regular posts
    // creates a object for ease of use 
    func handlepost(){
        object::delete("POSTDATA")
        POSTDATA : "POSTDATA"
        split = split(trim($POSTDATA),"&")
        if len(split) > 1 {
            for x in split{
                if x != ""{
                    if instring(x,"=") == true {
                        property = decode_html_url(splitselect(x,"=",0))
                        POSTDATA.*property = decode_html_url(splitselect(x,"=",1))
                    }
                }
            }
        }
        else{
            prop = decode_html_url(splitselect($POSTDATA,"=",0))
            POSTDATA.*prop = decode_html_url(splitselect($POSTDATA,"=",1)) 
        }
    }
    func start(){
        $userip = "unset"//set default
        if $serverbind == ""{
            $serverbind = http::bind(self.ip,self.port)
        }
        return "ok"
    }
    func stop(){
        break "coroutine_httpserverlistener"
    }
    func listpublicfiles(){
        index = ""
        itemsindir = listdir(self.serverroot)
        for xitem in itemsindir{
            if instring(xitem,".nc") == true || instring(xitem,".html") == true {
                index = cat(index,@lf,"http://",server.ip,":" ,server.port,"/" ,xitem)
            }
        }
        print(index,"bg")
    }
    func setip(ip){
        self.ip = ip
    }
    func setpostmaxkb(kb){
        server.POSTbytesmax = 1024 * kb
    }
    func throttle(timeinms){
        // rerun the coroutine with a throttle
        coroutine "httpserverlistener" each timeinms{
            http::listen($serverbind)
        }
    }
    func init(){
        throttleMs = 80
        // throttle the server so the powerusage drops. adjust if you like.
        // timer gets reset when a user connects, because internally nscript function server.onconnect() is triggered when a request is done
        // server.onconnect() will only trigger if it exists, for this system we reset the timer there so the co-routine bellow will work properly
        //$activitytimer = timerinit()
        print("starting")
        //check if theres a webroot public folder, if not creates it.
        indexnc = cat(server.serverroot,"/index.nc")
        if fileexists(indexnc) == false{
            print("Did not found a webroot public folder, creating:",server.serverroot," setting default index.nc with helloworld","y")
            dircreate(server.serverroot)
            filewrite(indexnc,"return \"helloworld!\"")
        }
        // allows the user to update 
        coroutine "webserverpostloader" {
            server.start()
            break self
        }

    }
    self.ip = "0.0.0.0"
    // on linux these port 80 is restrictedmode
    // use: sudo setcap CAP_NET_BIND_SERVICE=+eip /path/to/binary
    self.port = 8080
    self.serverroot = cat(@scriptdir,"/public/")
    self.webroot = server.serverroot
    self.POSTbytesmax = 1024 * 21024 // post datamax size
    self.init().throttle(5)
}
