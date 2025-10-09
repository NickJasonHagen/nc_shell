
extern crate nscript_lib;
use nscript_lib::*;

pub fn main() {
    let scriptcodedhex = "#NSCRIPTHEXCODE#";
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
