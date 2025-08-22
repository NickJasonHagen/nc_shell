//server
class server {
    func onconnect(clientIP){
        $userip = cat("ip:",clientIP)
        $activitytimer = timerinit()
        //print($POSTDATA,"bm")
    }
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
    func init(){
        throttleMs = 80
        // throttle the server so the powerusage drops. adjust if you like.
        // timer gets reset when a user connects, because internally nscript function server.onconnect() is triggered when a request is done
        // server.onconnect() will only trigger if it exists, for this system we reset the timer there so the co-routine bellow will work properly
        $activitytimer = timerinit()
        print("starting")
        // allows the user to update 
        coroutine "webserverpostloader" {
            server.start()
            break self
        }
        coroutine "server"{
            http::listen($serverbind)

        }

        coroutine "throttle"{
            if timerdiff($activitytimer) > 3000{
                sleep(throttleMs)
            }
        }
    }
    self.ip = "0.0.0.0"
    // on linux these port 80 is restrictedmode
    // use: sudo setcap CAP_NET_BIND_SERVICE=+eip /path/to/binary
    self.port = 8080
    self.serverroot = @scriptdir
    self.webroot = server.serverroot
    self.POSTbytesmax = 1024 * 1024// post datamax size
    self.init()
}



