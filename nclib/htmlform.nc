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


