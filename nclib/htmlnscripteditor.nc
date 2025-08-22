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