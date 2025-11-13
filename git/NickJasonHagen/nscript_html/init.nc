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
    func link(param1,param2,param3){
        ret = cat "index.nc?#TAG#&api&" self.apikey "&" param1  "&" param2  "&" param3
        return ret
    }
    func oncall(){
        //default ,overwrite for custom behaviour

    }

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
    func modal(button,title,text,fwbutton,url){
        ret = #raw 

            <!-- Button trigger modal -->
            <button type="button" id="myInput" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#myModal">
            #BUTTON#
            </button>

            <!-- Modal -->
            <div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="myModalLabel">#TITLE#</h1>
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
            const myModal = document.getElementById('myModal')
            const myInput = document.getElementById('myInput')

            myModal.addEventListener('shown.bs.modal', () => {
            myInput.focus()
            })
            </script>
         #endraw
        replacebyref(ret,"#TITLE#",title)
        replacebyref(ret,"#TEXT#",text)
        replacebyref(ret,"#FWBUTTON#",fwbutton)
        replacebyref(ret,"#BUTTON#",button)
        replacebyref(ret,"#URL#",url)
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
}
class table{
    func createtable(id,itemsarray,colortext,colorbk){
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
         if theme == ""{
            theme = "thead-dark"
         }
         tmp = cat tmp "<table class=" @quote "table table-striped" @quote ">" id " <thead><tr>" 
        for item in itemsarray{
            if item != "" {
                tmp = cat tmp @lf "<th>" item "</th>"
            }
        }
        
        tmp = cat tmp @lf "</tr></thead><tbody>"
        replacebyref(tmp,"#COLOR#",colortext)
        replacebyref(tmp,"#COLORBK#",colorbk)
        replacebyref(tmp,"#STRIPED#",striped)
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

class color{
    self.blue = "rgb(0, 47, 255)"
    self.green = "rgb(0, 255, 64)"
    self.red = "rgb(255, 0, 0)"
    self.yellow = "rgb(246, 255, 0)"
    self.purple = "rgb(145, 6, 205)"
    self.pink = "rgb(205, 6, 155)"
    self.brown = "rgb(104, 59, 8)"
    self.orange = "rgb(255, 149, 0)"
    self.grey = "rgb(117, 113, 109)"
    self.white = "rgb(255, 255, 255)"
    self.black = "rgb(0, 0, 0)"
}


class htmlbase64{
    func fileform(id,name,url){
        ret = replace(self.fileform)
    }
    self.fileform = #raw
        <div id="info">Select file to upload and upload..</div>
        <input type="file" id="myfile">Click Me!</input>
        <input type="textfield" id="myfilename">filename</input>
        <button id="myButton">Klik</button>
        <div id="pulsebox"></div>
        <script>
            async function postData(url = '', data = {}) {
                const response = await fetch(url, {
                    method: 'POST', // *GET, POST, PUT, DELETE, etc.
                    mode: 'cors', // no-cors, *cors, same-origin
                    cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
                    credentials: 'same-origin', // include, *same-origin, omit
                    headers: {
                    'Content-Type': 'multipart/form-data'
                    },
                    redirect: 'follow', // manual, *follow, error
                    referrerPolicy: 'no-referrer', // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
                    body: JSON.stringify(data) // body data type must match "Content-Type" header
                });
                
                return response.json(); // parses JSON response into native JavaScript objects
            }

            const toBase64 = file => new Promise((resolve, reject) => {
                const reader = new FileReader();
                reader.readAsDataURL(file);
                reader.onload = () => resolve(reader.result);
                reader.onerror = error => reject(error);
            });
            
            document.getElementById('myButton').addEventListener('click', async () => {
                const file = document.querySelector('#myfile').files[0];
                const baseString = await toBase64(file);
                postData('/b64.nc?nakkienekjeweetswa.jpg&', { data: baseString }).then(response => document.getElementById('pulsebox').prepend('Upload Succesfull'));

            });
        </script>
    #endraw
}

class form{
    // start a form, url will be set by its self, only set a different one if you need to post to some specific endpoint.
    // this class is designed to respond to posts automaticly using the .onpost() function
    // classes can be build like myform.new() myform.input("name","enter your name","defaultdata") myform.build()
    // in the index forward the post response like *$param3.onpost()
    func new(buttonname,url,width){
        if buttonname == "" {
            buttonname = "submit"
        }
        if width == ""{
            width = "600px"
        }
        if url == "" {
            url = cat("index.nc?#TAG#&post&",self,"&&&&")
        }
        self.innerdata = "" //reset
        self.data = replace(htmlform.form,"#URL#",url)
        replacebyref(self.data,"#WIDTH#",width)
        
        
    }
    // triggered function on web entree (index), overwrite this function on your new class to handle what needs to be done
    // when the form gets posted.
    func onpost(){
        return "post received"
    }
    //text label field
    func label(text){
        self.innerdata = cat self.innerdata replace(htmlform.label,"#TXT#",text)

    }
    func nscripteditor(id,code,color){
        ret = html_nscript_editor.spawn(id,code,color)
        self.innerdata &= ret
    }
    func switch(id,label,value){
        //<input class="form-check-input" type="checkbox" id="#ID#" name="#ID#" checked="#VALUE#">
        this = #raw
            <label class="form-check-label" for="#ID#">#LABEL#</label>
            <input type="checkbox" id="#ID#" style="color:rgb(73, 170, 62);background-color:rgb(189, 38, 38);" #VALUE# data-toggle="toggle">
        #endraw
        replacebyref(this,"#ID#",id)
        replacebyref(this,"#LABEL#",label)
        if value == true {
             this = replace(this,"#VALUE#","checked")
        }
        else{
            //self.innerdata = replace(self.innerdata,"#VALUE#","off")
            this = replace(this,cat("checked=",@quote,"#VALUE#",@quote),"")
        }
        self.innerdata &= this
    }
    //text input field
    func input(id,label,value,require){
        self.innerdata = cat self.innerdata replace(htmlform.input,"#IID#",id)
        if require == "true"{
            self.innerdata = replace(self.innerdata,"#REQUIRED#","required")
        }
        else{
            self.innerdata = replace(self.innerdata,"#REQUIRED#","")
        }
        self.innerdata = replace(self.innerdata,"#LABEL#",label)
        self.innerdata = replace(self.innerdata,"#VALUE#",value)
    }
    //text area field
    func textarea(id,label,value,require){
        self.innerdata = cat self.innerdata replace(htmlform.textarea,"#IID#",id)
        if require == "true"{
            self.innerdata = replace(self.innerdata,"#REQUIRED#","required")
        }
        else{
            self.innerdata = replace(self.innerdata,"#REQUIRED#","")
        }
        self.innerdata = replace(self.innerdata,"#LABEL#",label)
        self.innerdata = replace(self.innerdata,"#VALUE#",value)
    }
    //color input field
    func colorpicker(id,label,value,require){
        self.innerdata = cat self.innerdata replace(htmlform.color,"#IID#",id)
        if require == "true"{
            self.innerdata = replace(self.innerdata,"#REQUIRED#","required")
        }
        else{
            self.innerdata = replace(self.innerdata,"#REQUIRED#","")
        }
        self.innerdata = replace(self.innerdata,"#LABEL#",label)
        self.innerdata = replace(self.innerdata,"#VALUE#",value)
    }
    //email validation field
    func email(id,label,value,require){
        self.innerdata = cat self.innerdata replace(htmlform.email,"#IID#",id)
        if require == "true"{
            self.innerdata = replace(self.innerdata,"#REQUIRED#","required")
        }
        else{
            self.innerdata = replace(self.innerdata,"#REQUIRED#","")
        }
        self.innerdata = replace(self.innerdata,"#LABEL#",label)
        self.innerdata = replace(self.innerdata,"#VALUE#",value)
    }
    //fileboxfield
    func file(id,label,value,require){
        self.innerdata = cat self.innerdata replace(htmlform.file,"#IID#",id)
        if require == "true"{
            self.innerdata = replace(self.innerdata,"#REQUIRED#","required")
        }
        else{
            self.innerdata = replace(self.innerdata,"#REQUIRED#","")
        }
        self.innerdata = replace(self.innerdata,"#LABEL#",label)
        self.innerdata = replace(self.innerdata,"#VALUE#",value)
    }
    //password input field
    func password(id,label,value,require){
        self.innerdata = cat self.innerdata replace(htmlform.passwordfield,"#IID#",id)
        if require == "true"{
            self.innerdata = replace(self.innerdata,"#REQUIRED#","required")
        }
        else{
            self.innerdata = replace(self.innerdata,"#REQUIRED#","")
        }
        self.innerdata = replace(self.innerdata,"#LABEL#",label)
        //self.innerdata = replace(self.innerdata,"#VALUE#",value)
    }
    func checkbox(id,label,value,require){
        self.innerdata = cat self.innerdata replace(htmlform.checkbox,"#IID#",id)
        if require == "true"{
            self.innerdata = replace(self.innerdata,"#REQUIRED#","required")
        }
        else{
            self.innerdata = replace(self.innerdata,"#REQUIRED#","")
        }
        self.innerdata = replace(self.innerdata,"#LABEL#",label)
        if value == true {
             self.innerdata = replace(self.innerdata,"#VALUE#","on")
        }
        else{
            //self.innerdata = replace(self.innerdata,"#VALUE#","off")
            self.innerdata = replace(self.innerdata,cat("checked=",@quote,"#VALUE#",@quote),"")
        }
       
    }
    // a float input field
    func numberinput(id,label,value,require){
        self.innerdata = cat self.innerdata replace(htmlform.numberfield,"#IID#",id)
        if require == "true"{
            self.innerdata = replace(self.innerdata,"#REQUIRED#","required")
        }
        else{
            self.innerdata = replace(self.innerdata,"#REQUIRED#","")
        }
        self.innerdata = replace(self.innerdata,"#LABEL#",label)
        self.innerdata = replace(self.innerdata,"#VALUE#",value)
    }
    // a float input field with 0.05 steppings
    func priceinput(id,label,value,require){
        self.innerdata = cat self.innerdata replace(htmlform.pricefield,"#IID#",id)
        if require == "true"{
            self.innerdata = replace(self.innerdata,"#REQUIRED#","required")
        }
        else{
            self.innerdata = replace(self.innerdata,"#REQUIRED#","")
        }
        self.innerdata = replace(self.innerdata,"#LABEL#",label)
        self.innerdata = replace(self.innerdata,"#VALUE#",value)
    }
    // date picker 
    func date(id,value,require){

        self.innerdata = cat self.innerdata replace(htmlform.date,"#IID#",id)
        if require == "true"{
            self.innerdata = replace(self.innerdata,"#REQUIRED#","required")
        }
        else{
            self.innerdata = replace(self.innerdata,"#REQUIRED#","")
        }
        self.innerdata = replace(self.innerdata,"#VALUE#",value)
    }
    // dropbox combo field, options is a array 
    func combo(id,label,options,def,require){

        self.innerdata = cat self.innerdata replace(htmlform.combo,"#IID#",id)
        if require == "true"{
            self.innerdata = replace(self.innerdata,"#REQUIRED#","required")
        }
        else{
            self.innerdata = replace(self.innerdata,"#REQUIRED#","")
        }
        self.innerdata = replace(self.innerdata,"#TXT#",label)
        optionshtml = ""
        for xoption in options{
            optionshtml = cat optionshtml replace(htmlform.combo_option,"#ID#",xoption)
        }
        self.innerdata = replace(self.innerdata,"#DEFAULT#",replace(htmlform.combo_option,"#ID#",def))
        self.innerdata = replace(self.innerdata,"#OPTIONS#",optionshtml)
    }
    func submit(button){
        self.submitbutton = button
        self.innerdata = cat self.innerdata htmlform.submit
    }
    // finishes the elemenent
    func build(){
        
        self.data = replace(self.data,"#FORMELEMENTS#",self.innerdata)
        replacebyref(self.data,"#BUTTONNAME#",self.submitbutton)
    }
    // returns the build html element
    func html(){
        return self.data
    }
    self.data = ""// builder for the form
    self.innerdata = ""
}


class html_nscript_editor{
    func spawn(id,codestring,mode,color,width,height){
        if width = ""{
            width = 0.8
        }
        if height = ""{
            height = 0.8
        }
        if color == ""{
            color ="rgb(22, 21, 21)"
        }
        ret = replace(self.raw,"#ID#",id)
        if mode == "" || mode == "nscript"{
            replacebyref(ret,"#MODE2#","nscript")
            mode = "swift"
        }
        // some require simple mode
        if mode = "rust" {
            additionalmode = #raw
                <script src="highlighting/mode_simple.js"></script>
            #endraw
        }
        else{
            additionalmode = ""
        }
        
        replacebyref(ret,"#CODE#",codestring)
        replacebyref(ret,"#MODE#",mode)
        replacebyref(ret,"#MODE2#",mode)
        replacebyref(ret,"#COLOR#",color)
        replacebyref(ret,"#WIDTH#",width)
        replacebyref(ret,"#HEIGHT#",height)
        replacebyref(ret,"#ADD#",additionalmode)
        return ret
    }
    self.raw = #raw
            <link rel="stylesheet" href="/codemirror.css">
            <link rel="stylesheet" href="/dracula.css">
            
            <style>
            .#ID#nscripteditorcontainer {
                    display: flex;
                    background-color: #COLOR#;
                    color: rgb(231, 246, 234);
                    font-size: 11;
                }
            
                .#ID#code-editor{
                    width: 100%;
                    height: 100%;
                    background-color: #COLOR#;   
            } 
            </style>


            <div class="#ID#nscripteditorcontainer">
            <textarea name="#ID#" id="#ID#code-editor">#CODE#
            </textarea>
            </div>
            
            <script src="codemirror.js"></script>
            #ADD#
            <script src="highlighting/#MODE2#.js"></script>
            
            <script>


            document.addEventListener("DOMContentLoaded", function() {
            var editor = CodeMirror.fromTextArea(document.getElementById("#ID#code-editor"), {
                lineNumbers: true, // Show line numbers in the editor
                mode: "#MODE#", // Set the default language mode to Swift
                theme: "dracula", // Set the theme (optional)
                
            });
            editor.setSize(screen.width*#WIDTH#,screen.height*#HEIGHT#);
            });
        </script>
    #endraw
}


class rawhtml{
    // holds the raw data to build a form ( is set sepperatly so form spawns dont inherent these properties)
    //functions are in class html
    func load(){
        self.name = "rawhtml"
        self.but = #raw
            <a href="#URL#">
            <button type="button" class="#CLASS#">
            <i class="#ICON#"> </i> #NAME#
            </button>
            </a>

        #endraw
        self.fetch = #raw
            <div id="#ID#result"></div>
            
            <script>
            let #ID#intervalId = null;
            fetch('#URL#')
            .then(response => {
                return response.text();
            })
            .then(data => {
                let #ID#intervalId = null;
                #ID#intervalId = setInterval(() => {
                fetch('#URL#')
                    .then(response => {
                        return response.text();
                    })
                    .then(data => {
                    document.getElementById("#ID#result").innerHTML = data;
                    });
                }, #TIME#); 
            })
            .catch(error => {
                console.error('Error:', error);
                // handle error or display an error message to the user
            });

            // Clear the interval when the page loads (optional)
            window.addEventListener('load', () => {
            clearInterval(#ID#intervalId);
            });
            </script>
        #endraw
        self.updateddiv = #raw
            <div id="#ID#result">#VALUE#</div>
        #endraw
        // <div id="#ID#result">some</div>
        self.updateddivbutton = #raw
           
            <button id="#ID##NAME#refreshButton" class="#CLASS#">
            <i class="#ICON#"> </i>#NAME#</button>
            <script>
                function #ID##NAME#callServer() {
                fetch('#URL#')
                    .then(response => {
                        return response.text();
                    })
                    .then(data => {
                    document.getElementById("#ID#result").innerHTML = data;
                    })
                    .catch(error => console.error('Error:', error));
                }
                // Add event listener for refresh button click
                document.getElementById("#ID##NAME#refreshButton").addEventListener("click", #ID##NAME#callServer);
            </script>
        #endraw
        self.updateddivinputbutton = #raw
            <input id="#ID##NAME#refreshInput" class="#CLASS#">
            <button id="#ID##NAME#refreshButton" class="#CLASS#">
            <i class="#ICON#"> </i>#NAME#</button>
            <script>
                function #ID##NAME#callServer() {
                fetch('#URL#')
                    .then(response => {
                        return response.text();
                    })
                    .then(data => {
                    document.getElementById("#ID#result").innerHTML = data;
                    })
                    .catch(error => console.error('Error:', error));
                }
                // Add event listener for refresh button click
                document.getElementById("#ID##NAME#refreshButton").addEventListener("click", #ID##NAME#callServer);
            </script>
        #endraw
        self.timedclick = #raw
            <a id="myLink" style="display: none;" href="#URL#">#URL#</a>
            <script>
                function simulateClick(linkId, delay) {
                    // Check if the link exists in the document
                    const linkElement = document.getElementById(linkId);
                    if (!linkElement) {
                        console.log(`Link element with ID ${linkId} not found.`);
                        return;
                    }

                    // Add an event listener to wait for the document to finish loading
                    document.addEventListener("DOMContentLoaded", function() {
                        try {
                            // Simulate a click on the link after the delay
                            setTimeout(() => {
                                linkElement.click();
                            }, delay);
                        } catch (error) {
                            console.error(`Error simulating click on link with ID ${linkId}:`, error);
                        }
                    });
                }

                // Example usage: simulate a click on a link after 3 seconds
                simulateClick("myLink", #TIME#);        

            </script>

        #endraw
        self.list = #raw
            <a href="##ID#" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle"><i class="#ICON#" style="color:#COLOR#;"></i> <span>#NAME#</span></a>
            <ul class="collapse list-unstyled" id="#ID#">
                #ITEMS#
            </ul>
        #endraw
        self.listitem = #raw
            <li class="listitemsstyle"><a href="#URL#">➔ <span>#NAME#</span></a></li>
        #endraw
        self.auto = #raw
            <!DOCTYPE html><html><head><title>Auto Click Link</title></head><body>
            <a id="myLink" href="#URL#">Go to Example</a>
            <script>
            document.addEventListener("DOMContentLoaded", function() {
            let link = document.getElementById("myLink");
            if (link) {
                link.click();
            }
            });
            </script></body></html>
        #endraw
        self.barcode = #raw
            <div style="background-color: #FFFFFF; color: #000000; font-family: 'Libre Barcode 39 Text', sans-serif; font-size: 24px;">#TEXT#</div>
        #endraw
        self.login = #raw
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>#TITLE#</title>
                <!-- Bootstrap CSS -->
                <link href="bootstrap.min.css" rel="stylesheet">
                <style>
                    body {
                        background: #2c2e32;
                        min-height: 100vh;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        padding: 20px;
                    }
                    .login-container {
                        background: #1f2021;
                        padding: 3rem;
                        border-radius: 20px;
                        box-shadow: 0 0 30px rgba(0, 0, 0, 0.5);
                        width: 100%;
                        max-width: 450px;
                        border: 1px solid #34495e;
                    }
                    .login-header {
                        text-align: center;
                        margin-bottom: 2.5rem;
                        color: #ecf0f1;
                    }
                    .login-header h2 {
                        font-size: 2rem;
                        font-weight: 700;
                        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
                    }
                    .login-header .portal-text {
                        font-size: 1.25rem;
                        font-weight: 600;
                        color: #3498db;
                        letter-spacing: 1px;
                        text-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
                    }
                    .form-control {
                        background: #484b4e;
                        border: none;
                        color: #ecf0f1;
                        padding: 0.75rem;
                    }
                    .form-control:focus {
                        background: #6d6e6f;
                        color: #ecf0f1;
                        border-color: #7c8285;
                        box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
                    }
                    .form-control::placeholder {
                        color: #95a5a6;
                    }
                    .btn-login {
                        background: #495156;
                        border: none;
                        padding: 0.75rem;
                        transition: all 0.3s ease;
                        font-weight: 600;
                    }
                    .btn-login:hover {
                        background: #586f7f;
                        transform: translateY(-2px);
                        box-shadow: 0 4px 15px rgba(52, 152, 219, 0.4);
                    }
                </style>
            </head>
            <body>
                <div class="login-container">
                    <div class="login-header">
                        <h2>#CFG_NAME#</h2>
                        <p class="portal-text">#CFG_INFO#</p>
                    </div>
                    #LOGINMSG#
                    <form id="loginForm" method="POST" action="/index.nc?weblogin&#param3#&#param4#&">
                        <div class="mb-3">
                            <label for="loginId" class="form-label text-light">Login ID</label>
                            <input type="text" class="form-control" id="loginId" name="loginId" placeholder="Enter Login ID" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label text-light">Password</label>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Enter Password" required>
                        </div>

                        <button type="submit" class="btn btn-login w-100 mb-3">Login</button>
                    </form>
                </div>
                <script>
                    document.addEventListener('DOMContentLoaded', () => {
                        // Check if loginId is stored and pre-fill it
                        const storedLoginId = localStorage.getItem('loginId');
                        if (storedLoginId) {
                            document.getElementById('loginId').value = storedLoginId;
                            document.getElementById('rememberMe').checked = true;
                        }
                    });

                    function handleLogin(event) {
                        const rememberMe = document.getElementById('rememberMe').checked;

                        if (rememberMe) {
                            const loginId = document.getElementById('loginId').value;
                            localStorage.setItem('loginId', loginId); // Save loginId in localStorage
                        } else {
                            localStorage.removeItem('loginId'); // Remove loginId if "Remember Me" is not checked
                        }
                    }
                </script>
            </body>
            </html>

#endraw
    }
    self.load()
}

class htmlform{
    func load(){
        self.form = #raw
            <style>
            .custom-buttons {
                max-width: #WIDTH#;
                margin: 10px auto;
                display: flex;
                justify-content: space-around;
                gap: 5px;
            }
            .custom-buttons:hover {
                background: #586f7f;
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(37, 65, 84, 0.4);
            }
            .custom-form-container {
                max-width: #WIDTH#;
                margin: 20px auto;
                padding: 20px;
                background-color:rgb(42, 42, 42);
                color: rgb(202, 202, 202);
            border: 1px solidrgb(67, 91, 114);
                border-radius: 10px;
                box-shadow: 0 6px 10px rgba(58, 50, 207, 0.1);
            }
            .form-control {

                background-color:rgb(35, 34, 34);
                color: rgb(202, 202, 202);
                box-shadow: 0 4px 8px rgba(87, 98, 110, 0.1);
                
            }
            .form-control:hover {
                background:rgb(47, 55, 61);
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(52, 152, 219, 0.4);
            }
            .form-control:focus {
                background:rgb(65, 68, 71);
                color: #ecf0f1;
                border-color:rgb(111, 165, 192);
                box-shadow: 0 0 0 0.2rem rgba(83, 179, 242, 0.25);
            }
            .form-control:autofill {
                color:rgb(252, 255, 255);
                background:rgb(65, 68, 71);
            }
            </style>
            <div class="custom-form-container">
            <form method="POST" action="#URL#" enctype="plaintext/html">
            #FORMELEMENTS#
            
            </form>
            </div>
        #endraw
        self.submit = #raw
            <button type="submit" class="btn btn-primary btn-block">#BUTTONNAME#</button>
        #endraw
        //datepicker field
        self.date = #raw
            <div class="form-group">
            <label for="date">Datum:</label>
            <input type="date" class="form-control" id="#IID#" name="#IID#" value="#VALUE#" #REQUIRED# > 
            </div>
        #endraw
        // inputfield
        self.input = #raw
            <div class="form-group">
            <label for="host">#LABEL#</label>
            <input type="text" class="form-control" id="#IID#" name="#IID#" value="#VALUE#" #REQUIRED# >
            </div>
        #endraw
        self.textarea = #raw
            <div class="form-group">
            <label for="host">#LABEL#</label>
            <textarea class="form-control" id="#IID#" name="#IID#" rows="number" cols="number"  #REQUIRED#>#VALUE#</textarea>
            </div>
        #endraw
        // color
        self.color = #raw
            <div class="form-group">
            <label for="host">#LABEL#</label>
            <input type="color" class="form-control" id="#IID#" name="#IID#" value="#VALUE#" #REQUIRED# >
            </div>
        #endraw
        // email
        self.email = #raw
            <div class="form-group">
            <label for="host">#LABEL#</label>
            <input type="email" class="form-control" id="#IID#" name="#IID#" value="#VALUE#" #REQUIRED# >
            </div>
        #endraw
        // filebox
        self.file = #raw
            <div class="form-group">
            <label for="host">#LABEL#</label>
            <input type="file" class="form-control" id="#IID#" name="#IID#" value="#VALUE#" #REQUIRED# >
            </div>
        #endraw
        // combo dropbox 
        self.combo = #raw
            <div class="form-group">
            <label for="status">#TXT#</label>
            <select class="form-control" id="#IID#" name="#IID#" #REQUIRED# >
            #DEFAULT#
            #OPTIONS#
            </select>
            </div>
        #endraw
        // combo option, used in combo
        self.combo_option = #raw
            <option value="#ID#">#ID#</option>
        #endraw
        // pricefield step by 0,05
        self.pricefield = #raw
            <div class="form-group">
            <label for="price">#LABEL#</label>
            <input type="number" class="form-control" id="#IID#" name="#IID#" step="0.05" value="#VALUE#" #REQUIRED# >
            </div>
        #endraw
        // inputfield number
        self.numberfield = #raw
            <div class="form-group">
            <label for="price">#LABEL#</label>
            <input type="number" class="form-control" id="#IID#" name="#IID#" value="#VALUE#" #REQUIRED# >
            </div>
        #endraw
        // password field 
        self.passwordfield = #raw
            <div class="mb-3">
            <label for="password" class="form-label text-light">#LABEL#</label>
            <input type="password" class="form-control" id="#IID#" name="#IID#" placeholder="Enter Password"  #REQUIRED#>
            </div>
        #endraw
        // checkbox html
        self.checkbox = #raw
            <div class="form-check">
            <input type="checkbox" class="form-check-input" id="#IID#" name="#IID#" checked="#VALUE#"  #REQUIRED# >
            <label class="form-check-label" for="checkbox">#LABEL#</label>
            </div>
        #endraw
        self.label = #raw
            <div class="form-group">
            <label for="status">#TXT#</label>
            </div>
        #endraw
    }
    self.load()
}
class icons{
    self.printer = #raw 
        <i class="fa fa-print"> </i>
     #endraw
    self.check = #raw 
        <i class="fa fa-check"> </i>
    #endraw
    self.cross = #raw 
        <i class="fa fa-times"> </i>
    #endraw

}
func icon(name){
    ico = #raw 
        <i class="fa fa-#ID#"> </i>
    #endraw  
    return replace(ico,"#ID#",name)
}
