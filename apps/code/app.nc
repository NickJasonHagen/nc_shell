class code{
    func init(){
        self.register = cat(self.appdir,"reg.njh")
        njh::save("#","-",self.register)
        //print(self.register,"m")
        njh::filetoobject(self.register,"ncoderegister")
        object::index("ncoderegister") !
        match $cmdarg2{
            "list" =>{
                index = object::index("ncoderegister")
                msg = cat "Which index number would you like to open ?" @lf
                i = 0
                for x in index{
                    msg &= i " : " x @lf
                    i ++
                }
                itemid = terminalinput(msg,0)
                
                t = print(index[itemid],"bb")
                print(cat("opening ",t))
                run(cat("code ",ncoderegister.*t))
                run(cat("thunar ",ncoderegister.*t))
            }
            "add" => {
                path = stringbetween(runwait("pwd"),"Stdout: ",@lf)
                name = $cmdarg3
                ncoderegister.*name = path
                string = njh::fromobject("ncoderegister")
                filewrite(self.register,string)
                print(cat("added ",path," as ",$cmdarg3))
            }
            "remove" =>{
                path = stringbetween(runwait("pwd"),"Stdout: ",@lf)
                name = $cmdarg3
                object::deleteproperty("ncoderegister",name)
                njh::objecttofile("ncoderegister",self.register)
                print(cat("removed ",name),"g")
            }
            _ => {
                run(cat("code ",njh::load(cat("#",$cmdarg2),self.register)))
                run(cat("thunar ",njh::load(cat("#",$cmdarg2),self.register)))
                //runwait("echo error ?") !
            }
        }
    }
    code : ncapp
    //"loaded ncode" !
}
code.init()