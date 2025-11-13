class ytdl{
    func download(url,filename){
        if instring(url,"&&") == true{
            print("illigal command attempt @ ytdl.download(), security returned:","r")
            return
        }
        command = cat(@nscriptpath,"/bin/yt-dlp_linux -o \"",filename,"\"  \"",url,"\"")
        run(command)
    }
}
