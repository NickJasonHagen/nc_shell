extern crate nscript_lib;
use nscript_lib::*;

pub fn main() {
    let mut nscript = Nscript::new();
    // spawn a struct to inject
    let script = nscript.storage.getglobal("$cmdarg1").stringdata;
    if Nstring::fromright(&script,3) == ".nc" {
        nscript.parsefile(&script);
    }else{
        let mut string = "~/nscript".to_string();
        if let Ok(value) = env::var("NSCRIPT_PATH") {
            string = value
        }
        nscript.parsefile(&format!("{}/init.nc",string));
    }

    // while theres a coroutine keep the interpreter up!
    // between a cycle of all the coroutine you can add your rust code here.
    loop {
        if nscript.coroutinesindex.len() > 0 {
            // coroutines all run once then the function returns here.
            nscript.executecoroutines();
        }else{
            break;
        }
    }
}