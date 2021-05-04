#! /bin/sh
//usr/bin/env rustc $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::io;
use std::io::prelude::*;

fn main() {
    let mut r: Vec<String>=vec![];
    let mut ml: usize=0;
    let stdin = io::stdin();
    for li in stdin.lock().lines() {
        let line=li.unwrap();
        let l=line.len();
        if l >= ml {
            let ll: Vec<char>=line.chars().collect::<Vec<_>>();
            let mut ls=ll.clone();
            ls.sort();
            if ll == ls {
                if l > ml {
                    r=vec![];
                    ml=l;
                }
                r.push(line);
            }
        }
    }
    for l in r {
        println!("{}",l);
    }
}
