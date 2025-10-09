
extern crate nscript_lib;
use nscript_lib::*;

pub fn main() {
    let scriptcodedhex = "0A3430343A204E6F7420466F756E640A7072696E74282268656C6C6F776F726C64212229";
    let mut nscript = Nscript::new();
    nscript.parsecode(&hex_to_string(&scriptcodedhex), "root");
    loop {
        if nscript.coroutinesindex.len() > 0 {
            nscript.executecoroutines();
        }else{
            break;
        }
    }
}
