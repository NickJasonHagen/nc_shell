class package{
    self.name = "#PACKAGENAME#"
    self.version = "1.000"
}
func include(file){
    if $cmdarg1 == "run" { // using the dev envoirement
        init nscript.include(file) // set $cmdarg3 to update to overwrite and update
    }
    else{
        init cat("include/",file) // standalone mode
    }
}