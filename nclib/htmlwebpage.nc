class config{
    self.database = "./system/DB/"
    self.userdir = cat self.database "users/"
}
class webpage{
    func replacetags(site,tag){
        site = replace(site,"#TAG#",tag)
        replacebyref(site,"#Username#",*tag.name)
        replacebyref(site,"#PARAM2#",$param2)
        replacebyref(site,"#PARAM3#",$param3)
        replacebyref(site,"#PARAM4#",$param4)
        replacebyref(site,"#PARAM5#",$param5)
        replacebyref(site,"#PARAM6#",$param6)
        replacebyref(site,"#CFG_NAME#",server_config.name)
        replacebyref(site,"#CFG_TITLE#",server_config.title)
        replacebyref(site,"#CFG_INFO#",server_config.info)
        replacebyref(site,"#LIST#",menulist.load())
        return site
    }
    //self.index = fileread("./system/template/main/indexraw.html")
    self.login = fileread("./system/template/main/login.html")
}
class menulist{
    func load(){
        list = ""
        for xitem in object::index("moduleregister"){
            //print(cat("loaded module list ",xitem),"bm")
            list = cat list *xitem.getlist()
        }
        return list
    }
}
class module{
    
    func construct(){
        pageindex = cat "modulepageindex_" self
        object::delete(pageindex) // clear all data first
        moduleregister.*self = self
        //object::delete(cat("modulepageindex_",self))
        //print(cat("constructing ->",self),"g")


    }
    func destruct(){
        object::deleteproperty("moduleregister",self)
        object::delete(cat("modulepageindex_",self))
        //print(cat("destructing ->",self),"r")
    }
    func index(){
        return object::index("moduleregister")
    }
    func html(page){
        pageindex = cat "modulepageindex_" self
        return *pageindex.*page
    }
    func pushpage(page,content){
        pageindex = cat "modulepageindex_" self
        //*pageindex.*page = page
        *pageindex.*page = cat *pageindex.*page content
    }
    func getpage(page){
        
        pageindex = cat "modulepageindex_" self
        return *pageindex.*page
    }
    func setlist(listhtml){
        self.menulist = listhtml
    }
    func getlist(){
        if self.moduletype == "admin" {
            if usertag.checkadmin($param1) == true {
                self.createlist()
            }
            else{
                return ""
            }
            
        }
        else{
            self.createlist()
        }

        return self.menulist
    }
    func build(){
        self.createlist()
    }
    func createlist(){
        
        object::delete("tmplist")
        tmplist : list
        tmplist.new(self,self.icon,self.iconcolor)
        functions = object::functions(self)
        all = arraysearch(functions,"page_")
        for xpage in all{
            xpage = replace(xpage,"page_","")
            tmplist.item(xpage,cat("index.nc?",$param1,"&module&",self,"&",xpage,"&&&&"))
        }
        tmplist.build()
        self.menulist = tmplist.html()
    }
    func newpage(page){
        self.*page = ""
    }
        self.moduletype = "user"
}
class server_config{
    self.name = "test"
    self.title = "Nscript CMS"
    self.info = "nscript cms system dev"
}

class webui{
    // include to head
    func include(html){
        self.includes = arraypush(self.includes,html)
    }
    func show(content){
        head = ""
        page = self.index
        for x in self.includes{
            if instring(head,x) == false{
                head &= x @lf
            }
        }
        //print(head,"m") !
        replacebyref(page,"#HEADER#",head)
        replacebyref(page,"#MAIN#",content)
        //object::deleteproperty(self,"includes")
        self.includes = @new
        return page
    }

    self.index = #raw
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <!-- basic -->
            <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <!-- mobile metas -->
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <meta name="viewport" content="initial-scale=1, maximum-scale=1">
            <!-- site metas -->
            <title>#sitetitle#</title>
            <meta name="keywords" content="">
            <meta name="description" content="">
            <meta name="author" content="">
            <!-- site icon -->
             <script src="/jquery.js"></script>
            <link rel="icon" href="images/favicon.ico" type="image/favicon.ico" />
            <!-- bootstrap css -->
            <link rel="stylesheet" href="css/bootstrap.min.css" />
            <!-- site css -->
            <link rel="stylesheet" href="style.css" />
            <!-- responsive css -->
            <link rel="stylesheet" href="css/responsive.css" />
            <!-- select bootstrap -->
            <link rel="stylesheet" href="css/bootstrap-select.css" />
            <!-- scrollbar css -->
            <link rel="stylesheet" href="css/perfect-scrollbar.css" />
            <!-- Zorg ervoor dat Font Awesome geladen is -->
            <!-- <link href="css/font-awesome.min.css" rel="stylesheet"> -->
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
                    <!-- custom css -->
            <link rel="stylesheet" href="css/custom.css" />
            <!-- Barcode font -->
            <link href="css/barcode.css" rel="stylesheet">
            <link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
            <script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
            <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
           
            <![endif]-->
            #HEADER#
        </head>

        <style>
        .listitemsstyle:hover {
            background:rgb(83, 83, 104);
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(127, 136, 167, 0.4);
        }

        </style>
        <body class="dashboard dashboard_1">
        
            <div class="full_container">
                <div class="inner_container">
                    <!-- Sidebar  -->
                    <nav id="sidebar">
                    <div class="sidebar_blog_1">
                        <div class="sidebar-header">
                            <div class="logo_section">
                                <a href="index.nc?#TAG&&&&&"><img class="logo_icon img-responsive" src="images/logo/logo_icon.png" alt="#" /></a>
                            </div>
                        </div>
                        <div class="sidebar_user_info">
                            <div class="icon_setting"></div>
                            <div class="user_profle_side">
                                <div class="user_img"><img class="img-responsive" src="images/layout_img/Dtafalonso-Ios8-Finder.256.png" alt="#" /></div>
                                <div class="user_info">
                                <h6>#Username#</h6>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="sidebar_blog_2">
                        <h4>Menu</h4>
                        <ul class="list-unstyled components">
                            <li class="active">

                                #LIST#
                                #ADMINMENU#
                                </li>
                        </ul>
                    </div>
                    </nav>
                    <!-- end sidebar -->
                    <!-- right content -->
                    <div id="content">
                    <!-- topbar -->
                    <div class="topbar">
                        <nav class="navbar navbar-expand-lg navbar-light">
                            <div class="full">
                                <button type="button" id="sidebarCollapse" class="sidebar_toggle"><i class="fa fa-bars"></i></button>
                                <div class="logo_section">
                                    <div style="display: flex; align-items: center;">
                                        <a href="index.nc?#TAG#&&&&&" style="text-decoration: none; display: flex; align-items: center;">
                                            <img class="img-responsive" src="images/logo/logo_icon_white.png" alt="#" style="margin-right: 5px;">
                                            <span style="color: white; font-size: 25px; font-weight: bold; margin-top: 10px;">#MAINNAME#</span>
                                        </a>
                                    </div>
                                </div>

                                <div class="right_topbar">

                                <div class="icon_info">
                                    <ul class="user_profile_dd">
                                        <li>
                                            <a class="dropdown-toggle" data-toggle="dropdown"> <span class="name_user">Test menu</span></a>
                                            <div class="dropdown-menu">
                                            <a class="dropdown-item" href="index.nc?#TAG#&usersettings&&&&" style="padding-right: 20px; margin-right: 10px;">Account settings</a>
                                            <a class="dropdown-item" href="index.nc?#TAG#&logout&&&"><span>Logout</span> <i class="fa fa-sign-out"></i></a>
                                            </div>
                                        </li>
                                    </ul>
                                    <ul class="user_profile_dd">
                                        <li>
                                            <a class="dropdown-toggle" data-toggle="dropdown"><img class="img-responsive rounded-circle" src="images/layout_img/Dtafalonso-Ios8-Finder.256.png" alt="#" /><span class="name_user">#Username#</span></a>
                                            <div class="dropdown-menu">
                                            <a class="dropdown-item" href="index.nc?#TAG#&usersettings&&&&" style="padding-right: 20px; margin-right: 10px;">Account settings</a>
                                            <a class="dropdown-item" href="index.nc?#TAG#&logout&&&"><span>Logout</span> <i class="fa fa-sign-out"></i></a>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                </div>
                            </div>
                        </nav>
                    </div>
                    <!-- end topbar -->            
                    <!-- dashboard inner -->
                    <div class="midde_cont">
                        <div class="container-fluid">
                            <div class="row column_title">
                                <div class="col-md-12">
                                <div class="page_title">
                                    <h2>#PAGETITLE#</h2>


                            
                                </div>
                                </div>
                            </div>

                            #MAIN#
                    
                    </div>
                </div>
            </div>
            <!-- jQuery -->
            <script src="js/jquery.min.js"></script>
            <script src="js/popper.min.js"></script>
            <script src="js/bootstrap.min.js"></script>
            <!-- wow animation -->
            <script src="js/animate.js"></script>
            <!-- select country -->
            <script src="js/bootstrap-select.js"></script>
            <!-- owl carousel -->
            <script src="js/owl.carousel.js"></script> 
            <!-- chart js -->
            <script src="js/Chart.min.js"></script>
            <script src="js/Chart.bundle.min.js"></script>
            <script src="js/utils.js"></script>
            <script src="js/analyser.js"></script>
            <!-- nice scrollbar -->
            <script src="js/perfect-scrollbar.min.js"></script>   
            <script>var ps = new PerfectScrollbar('#sidebar');</script>     
            <!-- custom js -->
            <script src="js/custom.js"></script>
            <script src="js/chart_custom_style1.js"></script>
            <script src="js/pagination.js"></script>	  	  
        </body>
        </html>
    #endraw
}
