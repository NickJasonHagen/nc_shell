class inc{    
    include("rawhtml.nc")
    include("htmlcolors.nc")
    include("htmlform.nc")
    include("htmlnscripteditor.nc")
    include("json.nc")
    include("htmlwebpage.nc")
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
