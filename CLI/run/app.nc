init "./package.nc"
package.load()
if $cmdarg2 == ""{
    init "init.nc"
}
else{
    init $cmdarg2
}
