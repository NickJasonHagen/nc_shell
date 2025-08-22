class ytdl{
    func download(url,filename){
        command = cat(@nscriptpath,"/bin/yt-dlp_linux -o \"",filename,"\"  \"",url,"\"")
        run(command)
    }
}


// test werkt :P
//ytdl.download("https://www.youtube.com/watch?v=6twHgHjHUek","./Altiyan_Childs_masonary_expose.mp4")
