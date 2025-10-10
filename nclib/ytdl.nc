class ytdl{
    func download(url,filename){
        command = cat(@nscriptpath,"/bin/yt-dlp_linux -o \"",filename,"\"  \"",url,"\"")
        run(command)
    }
}

