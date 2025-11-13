class inc{    
    include("rawhtml.nc")
    include("htmlcolors.nc")
    include("htmlform.nc")
    include("htmlnscripteditor.nc")
    include("json.nc")
    include("htmlwebpage.nc")
}
class icons{
    func from(name){
        this = #raw 
        <i class="fa fa-#NAME#"> </i>
     #endraw
     return replace(this,"#NAME#",name)
    }
    self.printer = #raw 
        <i class="fa fa-print"> </i>
     #endraw
    self.check = #raw 
        <i class="fa fa-check"> </i>
    #endraw
    self.cross = #raw 
        <i class="fa fa-times"> </i>
    #endraw
    self.download = #raw 
        <i class="fa fa-times"> </i>
    #endraw
}

class exbase64{ // consumed by thread awaits.async
    func externbase64(base,ftype,fname,filedir){
        fname = replace(fname,"\\","/")
        splitname = split(fname,"/")
        len = len(splitname) - 1
        if len > 0{
            fname = splitname[len]
        }
        typesplit = split(fname,".")
        last = len(typesplit) - 1
        type = cat(".",typesplit[last])
        newname = cat(stringtoeval(replace(fname,type,"")),type)
        return base64tofile(base,cat(@scriptdir,filedir,"/",newname))
    }
    func doneexternbase64(ret){
        print("[base64:fileupload] ",ret,"by")
    }
}
class ok{
    self.result = "success"
}
class html{
    func autoclick(url){
        return replace(rawhtml.auto,"#URL#",url)
    }
    func click(url){
        return replace(rawhtml.*"auto","#URL#",url)
    }
    func loginpage(){
        site = replace(rawhtml.login,"#CFG_NAME#",server_config.name)
        replacebyref(site,"#CFG_TITLE#",server_config.title)
        replacebyref(site,"#CFG_INFO#",server_config.info)
        return site
    }
    func div(html){
        return cat("<div>",html,"</div>")
    }
    func span(html){
        return cat("<span>",html,"</span>")
    }
    func icon(icon){
        return cat("<i class=\"fa fa-",icon,"\"></i>")
    }
    func video(url,width,height,autoplay){
        raw = #raw
            <video controls width="#WIDTH#" height="#HEIGHT#" #AUTO#>
            <source src="#LINK#" type="video/mp4">
            Your browser does not support the video element.
            </video>
        #endraw
        replacebyref(raw,"#LINK#",url)
        replacebyref(raw,"#WIDTH#",width)
        replacebyref(raw,"#HEIGHT#",height)
        if autoplay == true{
            replacebyref(raw,"#AUTO#","autoplay")
        }
        else{
            replacebyref(raw,"#AUTO#","")
        }
        raw    
    }
    func audio(url,autoplay){
        raw = #raw
            <audio controls #AUTO#>
            <source src="#LINK#" type="audio/mpeg">
            Your browser does not support the audio element.
            </audio>
        #endraw
        replacebyref(raw,"#LINK#",url)
        if autoplay == true{
            replacebyref(raw,"#AUTO#","autoplay")
        }
        else{
            replacebyref(raw,"#AUTO#","")
        }
        raw    
    }
    func search(posturl,info){  
        html = #raw
        <form id="loginForm" method="POST" action="#URL#">
            <div style="max-width: 320px;">
            <div class="input-group shadow-sm">
                <input type="text" class="form-control" placeholder="#INFO#" id="text" name="text" aria-label="Search"
                style="border-top-right-radius: 0; border-bottom-right-radius: 0;">
                <button class="btn btn-outline-success" type="submit"
                style="border-top-left-radius: 0; border-bottom-left-radius: 0;">
                <i class="fas fa-search"></i>
                </button>
            </div>
            </div>
        </form>
        #endraw
        replacebyref(html,"#URL#",posturl)
        replacebyref(html,"#INFO#",info)
        html
    }
    func input(posturl,info,buttonname){
     string_or(buttonname,"submit")
        html = #raw
        <form id="loginForm" method="POST" action="#URL#">
            <div style="max-width: 320px;">
            <div class="input-group shadow-sm">
                <input type="text" class="form-control" placeholder="#INFO#" id="text" name="text" aria-label="Search"
                style="border-top-right-radius: 0; border-bottom-right-radius: 0;">
                <button class="btn btn-outline-success" type="submit"
                style="border-top-left-radius: 0; border-bottom-left-radius: 0;">
                #BUTTON#
                </button>
            </div>
            </div>
        </form>
        #endraw
        replacebyref(html,"#URL#",posturl)
        replacebyref(html,"#INFO#",info)
        replacebyref(html,"#BUTTON#",buttonname)
        html
    }
    func spinner(id,color1,color2,size,thickness,borderradius){
        raw = #raw
        <style>
        ##ID#loading {
        display: inline-block;
        width: #SIZE#px;
        height: #SIZE#px;
        border: #THICKNESS#px solid #COLOR2#;
        border-radius: #BORDER#%;
        border-top-color: #COLOR1#;
        animation: spin 1s ease-in-out infinite;
        }

        @keyframes spin {
        to {
            transform: rotate(360deg);
        }
        }
        </style>
        <div id="#ID#loading"></div>
        #endraw
        replacebyref(raw,"#ID#",id)
        replacebyref(raw,"#COLOR1#",string_or(color1," #636161ff"))
        replacebyref(raw,"#COLOR2#",string_or(color2," #313131"))
        replacebyref(raw,"#SIZE#",int_or(size,20))
        replacebyref(raw,"#THICKNESS#",int_or(thickness,5))
        replacebyref(raw,"#BORDER#",int_or(borderradius,50))
        raw
    }
   func bas64filehandler(path,fname){
        ftype = stringbetween($POSTDATA,"/",";base64")
        base = split($POSTDATA,"base64,")
        base = splitselect(base[1],"\"",0)
        if fname == ""{
            fname = stringbetween($POSTDATA,"fname\":\"","\"")
        }
        $POSTDATA = "" // reset that blob of global data..
        awaits.async("exbase64.externbase64","exbase64.doneexternbase64",trim(base),ftype,fname,path)
        return object::tojson("ok")
   }
   func base64fileupload(id,webentree,arg1,arg2,arg3,arg4,arg5,arg6){
    if instring(webentree,"?") == true{
        posturl = webentree
    }
    else{
        posturl = cat(webentree,"?",arg1,"&",arg2,"&",arg3,"&",arg4,"&",arg5,"&",arg6,"&")
    }
    
        // if filetypes == ""{
        //     filetypes = ".jpg, .jpeg, .png, .gif, .pdf, .zip"
        // }

        content = #raw
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
        .base64fileupload {
            background: #1f2021;
            padding: 3rem;
            border-radius: 5px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.5);
            width: 300px;
            max-width: 400px;
            border: 1px solid #34495e;
        }
        .base64fileupload-control {
            background: #484b4e;
            border-radius: 10px;
            border: 1px solid #34495e;
            color: #ecf0f1;
            width: 100%;
            padding: 15;
        }
        .base64fileupload-controldark {
            background: #1f2021;
            border-radius: 10px;
            border: 1px solid #5b5f62ff;
            color: #ecf0f1;
            width: 100%;
            padding: 15;
        }
        .base64fileupload-control:focus {
            background: #6d6e6f;
            color: #ecf0f1;
            border-color: #7c8285;
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }
        .base64fileupload-control::placeholder {
            color: #95a5a6;
        }
        .btn-base64fileupload {
            background: #287616ff;
            border-radius: 10px;
            color: #ecf0f1;
            border: none;
            padding: 15;
            transition: all 0.3s ease;
            font-weight: 600;
            width: 100%;
        }
        .btn-base64fileupload:hover {
            background: #76dd59ff;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.4);
        }
        .base64fileupload-control:hover {
            background: #586f7f;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.4);
        }
        </style>
        <div class="base64fileupload">
    <div id="#ID#pulsebox" class="base64fileupload-controldark">Select a file and enter a filename to start uploading.</div>
    <div><input type="file"  class="base64fileupload-control" id="#ID#myfile"></input></div>
    <div><button id="#ID#myButton" class="btn btn-base64fileupload">Upload</button></div>
   </div>
    
    <script>
          // Example POST method implementation:
          async function #ID#postData(url = '', data = {}) {
		//myfilename = ('#myfilename');
            // Default options are marked with *
            const #ID#response = await fetch(url, {
                method: 'POST', // *GET, POST, PUT, DELETE, etc.
                mode: 'cors', // no-cors, *cors, same-origin
                cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
                credentials: 'same-origin', // include, *same-origin, omit
                headers: {
                'Content-Type': 'multipart/form-data'
                // 'Content-Type': 'application/x-www-form-urlencoded',
                },
                redirect: 'follow', // manual, *follow, error
                referrerPolicy: 'no-referrer', // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
                body: JSON.stringify(data) // body data type must match "Content-Type" header
            });
            
            return #ID#response.json(); // parses JSON response into native JavaScript objects
        }

        const #ID#toBase64 = #ID#file => new Promise((resolve, reject) => {
            const #ID#reader = new FileReader();
            #ID#reader.readAsDataURL(#ID#file);
            #ID#reader.onload = () => resolve(#ID#reader.result);
            #ID#reader.onerror = #ID#error => reject(#ID#error);
        });
        
        document.getElementById('#ID#myButton').addEventListener('click', async () => {
            const #ID#file = document.querySelector('##ID#myfile').files[0];
            document.getElementById('#ID#pulsebox').innerHTML = "Encoding with Base64";
            var #ID#myfilename = document.getElementById('#ID#myfile').value;
            const #ID#baseString = await #ID#toBase64(#ID#file);
            document.getElementById('#ID#pulsebox').innerHTML = "Uploading!!";
            #ID#postData('#POSTURL#', { fname:#ID#myfilename,data: #ID#baseString}).then(#ID#response => document.getElementById('#ID#pulsebox').innerHTML ='Upload Succesfull');
        });

        </script>
        #endraw
        replacebyref(content,"#POSTURL#",posturl)
        //replacebyref(content,"#BSLINK#",bslink)
        replacebyref(content,"#ID#",id)
        content
    }

}
class list{
    func new(name,icon,color){
        if color == ""{
            color = "rgb(100, 157, 43)"
        }
        self.innerdata = ""
        self.data = replace(rawhtml.list,"#NAME#",name)
        replacebyref(self.data,"#ICON#",icon)
        replacebyref(self.data,"#COLOR#",color)
        replacebyref(self.data,"#ID#",name)
    }
    func item(name,url){
        item = replace(rawhtml.listitem,"#NAME#",name)
        replacebyref(item,"#URL#",url)       
        self.innerdata = cat self.innerdata item
    }
    func build(){
        replacebyref(self.data,"#ITEMS#",self.innerdata)
    }
    func html(){
        return self.data
    }
    self.data = ""
}
class content{
    func construct(){
        self.data = ""
    }
    func new(){
        self.data = ""
    }
    func push(html){
        self.data = cat self.data html
    }
    func html(){
        return self.data
    }

}
class page{
    func autoclick(url){
        return replace(rawhtml.auto,"#URL#",url)
    }   
}
class api{
    func construct(){
        api = stringtohex(cat("apikey_",self))
        *api.object = self
        *self.apikey = api
        api.*api = self // set the enc object on the api class 
        //*api : api // copy for oncall()
        return self
    }
    // url as a string
    func link(param1,param2,param3){
        ret = cat "index.nc?#TAG#&api&" self.apikey "&" param1 "&" param2 "&" param3
        return ret
    }
    // full html link element
    func htmllink(name,param1,param2,param3){
        ret = html.link(cat("index.nc?#TAG#&api&",self.apikey,"&",param1,"&",param2,"&",param3),name)
        return ret
    }
    func button(name,param1,param2,param3){
        ret = html.button(name,cat("index.nc?#TAG#&api&",self.apikey,"&",param1,"&",param2,"&",param3))
        return ret
    }
    func oncall(){
        //default ,overwrite for custom behaviour

    }
    self.requirelogin = true
 }
class js{
    func createbutton(id,name,url,icon,ref){
        if icon == ""{
            icon = "fas fa-arrow-right"
        }
        if ref == ""{
            ref = "btn btn-alert"
        }
        page = replace(rawhtml.updateddivbutton,"#URL#",url)
        replacebyref(page,"#ID#",id)
        replacebyref(page,"#NAME#",name)
        replacebyref(page,"#CLASS#",ref)
        replacebyref(page,"#ICON#",icon)
        return page
    }
    func button(id,name,url,icon,ref){
        if ref == ""{
            ref = "btn btn-primary"
        }
        return self.createbutton(id,name,url,icon,ref)
    }
    func okbutton(id,name,url,icon){
        if icon == ""{
            icon = "fas fa-check"
        }
        return self.createbutton(id,name,url,icon,"btn btn-success")
    }
    func trashbutton(id,name,url,icon){
        return self.createbutton(id,name,url,icon,"btn btn-danger")
    }
    func xbutton(id,name,url,icon){
        return self.createbutton(id,name,url,"fas fa-times","btn btn-danger")
    }
}

class html{
    func column(contentvec,bkcolor,txtcolor){
        if bkcolor == ""{
            bkcolor = "rgb(206, 206, 216)"
        }
        if txtcolor == ""{
            txtcolor = "rgb(0, 0, 0)"
        }
        ret = #raw
            <style>
            .columndiv {
                background:#BKCOLOR#;
                color:#TXTCOLOR#;
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(127, 136, 167, 0.4);
            }
            </style>
            <div class="columndiv">
            <div class="row align-items-end">
            #CONTENT#
            </div>
            </div>
        #endraw
        // innerpart
        col = #raw 
            <div class="col">
            #CONTENT#
            </div>
        #endraw
        innerdata = ""
        for x in contentvec{
            innerdata = cat(innerdata,replace(col,"#CONTENT#",x))
        }
        replacebyref(ret,"#TXTCOLOR#",txtcolor)
        replacebyref(ret,"#BKCOLOR#",bkcolor)
        replacebyref(ret,"#CONTENT#",innerdata)
        ret
    }
    func jumbotron(title,text,buttonname,url){
        raw = #raw
                <div class="p-5 mb-4 bg-body-tertiary rounded-3">
          <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">#TITLE#</h1>
            <p class="col-md-8 fs-4">
                #TEXT#
            </p>
            <a href="#URL#">
            <button class="btn btn-primary btn-lg" type="button">
              #BUTTON#
            </button></a>
          </div>
        </div>
        #endraw
        replacebyref(raw,"#TITLE#",title)
        replacebyref(raw,"#TEXT#",text)
        replacebyref(raw,"#BUTTON#",buttonname)
        replacebyref(raw,"#URL#",url)
        raw
    }
    func rowitemsstretched(itemsvec){
        raw = #raw 
        <div class="row align-items-md-stretch">
        #endraw
        data = string xitem in itemsvec{
            xitem
        }
        return cat(raw,data,"</div>")
    }
    func rowitems(itemsvec){
        raw = #raw 
            <div class="row">
        #endraw
        data = string xitem in itemsvec{
            xitem
        }
        return cat(raw,data,"</div></div>")
    }
    func card(innerdata,color,hovercolor){
        raw = #raw 
            <style>
                .account-card {
                background-color: #COLOR#;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                padding: 20px;
                text-align: center;
                margin-bottom: 20px;
                }
                .account-card:hover {
                background-color: #HOVERCOLOR#;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(29, 28, 28, 0.1);
                padding: 20px;
                text-align: center;
                margin-bottom: 20px;
                }

            </style>
            <div class="col-md-4">
            <div class = "account-card">
                #CARD#
            </div>
            </div>
      #endraw

        thisdiv = stringtohex(@now)
        color = string_or(color," #a9a6a6ff")
        hovercolor = string_or(hovercolor," #e2e2e2ff")
        replacebyref(raw,"#COLOR#",color)
        replacebyref(raw,"#HOVERCOLOR#",hovercolor)
        return replace(raw,"#CARD#",innerdata)
    }

    func accountcard(username,info,buttonname,url,color,hovercolor){
        raw = #raw 
        <style>
            .account-card {
                background-color: #COLOR#;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                padding: 20px;
                text-align: center;
                margin-bottom: 20px;
            }
            .account-card:hover {
                background-color: #HOVERCOLOR#;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(29, 28, 28, 0.1);
                padding: 20px;
                text-align: center;
                margin-bottom: 20px;
            }
            </style>
            <!-- Gebruiker 1 -->
            <div class="col-md-4">
                <div class="account-card">
                <i class="fas fa-user-circle account-icon"></i>
                <h4 class="font-weight-bold">Naam: <span class="text-primary">#USERNAME#</span></h4>
                <p>Rol: <span class="badge badge-danger">#INFO#</span></p>
                <a href="#URL#" class="btn btn-primary mt-3">#BUTTON#</a>
                </div>
            </div>
      #endraw
        thisdiv = stringtohex(@now)
        color = string_or(color," #a9a6a6ff")
        hovercolor = string_or(hovercolor," #e2e2e2ff")
        replacebyref(raw,"#COLOR#",string_or(color," #a9a6a6ff"))
        replacebyref(raw,"#HOVERCOLOR#",string_or(hovercolor," #e2e2e2ff"))
        replacebyref(raw,"#INFO#",string_or(info,"no info."))
        replacebyref(raw,"#BUTTON#",string_or(buttonname,"View"))
        replacebyref(raw,"#URL#",string_or(url,"#"))
        return replace(raw,"#USERNAME#",username)

    }
    func jumbotronsmall(title,text,buttonname,url){
        raw = #raw
          <div class="col-md-6">
            <div class="h-100 p-5 bg-body-tertiary border rounded-3">
              <h2>#TITLE#</h2>
              <p>
                #TEXT#
              </p>
              <button class="btn btn-outline-secondary" type="button">
                #BUTTON#
              </button>
            </div>
          </div>
        #endraw
        replacebyref(raw,"#TITLE#",title)
        replacebyref(raw,"#TEXT#",text)
        replacebyref(raw,"#BUTTON#",buttonname)
        replacebyref(raw,"#URL#",url)
        raw
    }
    func modal(button,title,text,fwbutton,url){
        ret = #raw 

            <!-- Button trigger modal -->
            <button type="button" id="#ID#myInput" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="##ID#myModal">
            #BUTTON#
            </button>

            <!-- Modal -->
            <div class="modal fade" id="#ID#myModal" tabindex="-1" aria-labelledby="#ID#myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="#ID#myModalLabel">#TITLE#</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    #TEXT#
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">close</button>
                    <a href="#URL#">
                    <button type="button" class="btn btn-primary">#FWBUTTON#</button>
                    </a>
                </div>
                </div>
            </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <script>
            const #ID#myModal = document.getElementById('#ID#myModal')
            const #ID#myInput = document.getElementById('#ID#myInput')

            #ID#myModal.addEventListener('shown.bs.modal', () => {
            #ID#myInput.focus()
            })
            </script>
         #endraw
        replacebyref(ret,"#TITLE#",title)
        replacebyref(ret,"#TEXT#",text)
        replacebyref(ret,"#FWBUTTON#",fwbutton)
        replacebyref(ret,"#BUTTON#",button)
        replacebyref(ret,"#URL#",url)
        replacebyref(ret,"#ID#",cat("md",lowercase(stringtohex(cat(url,@now,random(0,100,0))))))
        ret
    }
    func badge(text,color){
        badge = cat "<span style=" @quote "display: inline-block; padding: 3px 12px; font-size: 12px; font-weight: bold; color: white; background-color: #COLOR#; border-radius: 12px;" @quote "> #ITEM#</span>"
        replacebyref(badge,"#ITEM#",text)
        replacebyref(badge,"#COLOR#",color)
        return badge
    }
    func barcode(text){
        return replace(rawhtml.barcode,"#TEXT#",text)
    }
    func createbutton(name,url,icon,ref){
        if icon == ""{
            icon = "fas fa-arrow-right"
        }
        if ref == ""{
            ref = "btn btn-alert"
        }
        page = replace(rawhtml.but,"#URL#",url)
        replacebyref(page,"#NAME#",name)
        replacebyref(page,"#CLASS#",ref)
        replacebyref(page,"#ICON#",icon)
        return page
    }
    func button(name,url,icon,ref){
        if ref == ""{
            ref = "btn btn-primary"
        }
        return self.createbutton(name,url,icon,ref)
    }
    func okbutton(name,url,icon){
        if icon == ""{
            icon = "fas fa-check"
        }
        return self.createbutton(name,url,icon,"btn btn-success")
    }
    func trashbutton(name,url,icon){
        return self.createbutton(name,url,icon,"btn btn-danger")
    }
    func xbutton(name,url,icon){
        return self.createbutton(name,url,"fas fa-times","btn btn-danger")
    }
    func link(url,name){
        ishtml = cat "<a href=" @quote url @quote ">" name "</a>"
        return ishtml
    }

    func timedclick(url,time){
        rep = replace(rawhtml.timedclick,"#URL#",url)
        replacebyref(rep,"#TIME#",time)
        return rep
    }
    
    func updated(id,url,time){
        ret = replace(rawhtml.fetch,"#ID#",id)
        replacebyref(ret,"#URL#",url)
        replacebyref(ret,"#TIME#",time)
        return ret
    }
    func updatedbutton(id,name,url){
        ret = replace(rawhtml.updateddivbutton,"#ID#",id)
        replacebyref(ret,"#URL#",url)
        replacebyref(ret,"#NAME#",name)
        return ret
    }
    func updateddiv(id,value){
        ret = replace(rawhtml.updateddiv,"#ID#",id)
        replacebyref(ret,"#VALUE#",value)
        return ret
    }
    func linkalert(url,name){
        ishtml = cat "<a href=" @quote url @quote " class=" @quote "alert-link" @quote ">" name "</a>"
        return ishtml
    }
    func linkcolor(url,name,color){
        ishtml = cat "<a href=" @quote url @quote " style=" @quote "color: " color "; text-decoration: none; font-weight: bold;" @quote ">" name "</a>"
        return ishtml
    }
    func linkblank(url,name){
        toret = cat "<a href=" @quote url @quote " target=" @quote "_blank" @quote ">" name "</a>"
        return toret
    }  
    func imglink(url,imgpath,atltext){
        ishtml = cat "<a href=" @quote url @quote ">" self.img(imgpath,atltext) "</a>"
        return ishtml
    }
    func img(imgpath,alttext){
        if alttext == "" {
            alttext = "img"
        }
        ishtml = cat "<img src=" @quote imgpath @quote " alt=" @quote alttext @quote ">"
        return ishtml
    }
    func h1(html){
        return cat("<h1>",html,"</h1>")
    }
    func h2(html){
        return cat("<h2>",html,"</h2>")
    }
    func h3(html){
        return cat("<h3>",html,"</h3>")
    }
    func h4(html){
        return cat("<h4>",html,"</h4>")
    }
    func h5(html){
        return cat("<h5>",html,"</h5>")
    }
    func progress(percentage){

        ret = #raw
                <div class="progress" role="progressbar" aria-label="Basic example" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
                <div class="progress-bar" style="width: #PERCENTAGE#%;"></div>
                </div>
        #endraw
        return replace(ret,"#PERCENTAGE#",percentage)
    }
    func msg(textmsg,colorset){
        text2 = cat "<div class=" @quote "alert alert-primary" @quote " style=" @quote "font-size: 20px; font-weight: bold;" @quote" role=" @quote "alert" @quote ">" textmsg "</div>"
        if colorset == "red"{
            text2 = cat "<div class=" @quote "alert alert-danger" @quote " style=" @quote "font-size: 20px; font-weight: bold;" @quote" role=" @quote "alert" @quote ">" textmsg "</div>"
        }
        if colorset == "green"{
            text2 = cat "<div class=" @quote "alert alert-success" @quote " style=" @quote "font-size: 20px; font-weight: bold;" @quote" role=" @quote "alert" @quote ">" textmsg "</div>"
        }
        //msg = replace(self.raw,"#MAIN#",text2)
        return text2
    }
}
class table{
    func createtable(id,itemsarray,colortext,colorbk,innercolor,innerbkcolor){
        tmp = #raw 
            <style>
            .custom-buttons {
                max-width: 900px;
                margin: 10px auto;
                display: flex;
                justify-content: space-around;
                gap: 5px;
            }
            .custom-form-tablecontainer {
                max-width: 900px;
                margin: 20px auto;
                padding: 20px;
                background-color:#COLORBK2#;
                color: #COLOR2#;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .table {
                max-width: 900px;
                margin: 20px auto;
                padding: 20px;
                background-color:#COLORBK#;
                color: #COLOR#;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            </style>
            <div class="custom-form-tablecontainer">
            <div class="container-fluid">
        #endraw
         if color = ""{
            color = " rgb(255, 254, 254)"
         }
        if colorbk = ""{
            colorbk = " rgb(22, 21, 21)"
         }
        //  if theme == ""{
        //     theme = "thead-dark"
        //  }
         tmp = cat tmp "<table class=" @quote "table table-striped" @quote ">" id " <thead><tr>" 
        for item in itemsarray{
            if item != "" {
                tmp = cat tmp @lf "<th >" item "</th>"
            }
        }
        
        tmp = cat tmp @lf "</tr></thead><tbody>"
        replacebyref(tmp,"#COLOR#",colortext)
        replacebyref(tmp,"#COLORBK#",colorbk)
        replacebyref(tmp,"#COLOR2#",innercolor)
        replacebyref(tmp,"#COLORBK2#",innerbkcolor)
        //replacebyref(tmp,"#STRIPED#",striped)
        return tmp
    }

    func tableadditem(table,itemsarray){
        itemtmp = ""
        for xitem in itemsarray{
            if xitem != ""{
                itemtmp = cat itemtmp "<th>" xitem "</th>"
            }
        }
        
        return cat(table,"<tr>",@lf,itemtmp,@lf,"</tr>")
    }
    func tableadditemsingle(itemsarray){
        itemtmp = ""
        for xitem in itemsarray{
            if xitem != ""{
                itemtmp = cat itemtmp "<th>" xitem "</th>"
            }
        }
        return cat("<tr>",@lf,itemtmp,@lf,"</tr>")
    }
    func tablefinish(table){
        pagination = #raw
            
            <div class="pagination button_section button_style2">
            <!-- pagination -->
            <div class="btn-group mr-2" role="group" aria-label="First group">
            </div>
            
            </div>		
            </div>	
            </div>
            
        #endraw
        ret = cat(table,@lf,"</tr></tbody></table>",pagination)
        //print(ret)
        return ret
        //return cat(table,@lf,"</table class=",@quote,"table table-striped table-hover border rounded",@quote,">")
    }
}
class htmlbase64{
    self.raw = #raw
        <script>
        function uploadBase64(event) {
            const file = event.target.files[0];
            if (!file) return;

            // Get the base64 string from the selected file
            var reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById("base64Input").value = e.target.result;
            };

            // For debugging purposes, you might want to display the Base64 string as an image
            const img = document.createElement('img');
            img.src = 'data:image/jpeg;base64,' + file.toString();
            document.body.appendChild(img);

        }
        <script>
    #endraw
}


func icon(name){
    ico = #raw 
        <i class="fa fa-#ID#"> </i>
    #endraw  
    return replace(ico,"#ID#",name)
}