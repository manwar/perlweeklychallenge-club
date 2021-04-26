use std::io;
use std::io::prelude::*;
use regex::Regex;

fn main() {
    let vp=Regex::new(r"^ *(\+[0-9]{2}|\([0-9]{2}\)|[0-9]{4}) [0-9]{10} *$").unwrap();
    let stdin = io::stdin();
    for line in stdin.lock().lines() {
        let ll=line.unwrap();
        if vp.is_match(&ll) {
            println!("{}",ll);
        }
    }
}
