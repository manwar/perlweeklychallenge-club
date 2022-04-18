#! /bin/sh
//usr/bin/env rustc $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::io::{self, BufRead, BufReader};

fn main() {
    let mut b: Vec<String> = Vec::new();
    let reader = BufReader::new(io::stdin());
    for line in reader.lines() {
        let line = line.unwrap();
        let a: Vec<char> = line.chars().collect();
        let mut u: bool = true;
        for i in a.windows(2) {
            if i[0] > i[1] {
                u = false;
                break;
            }
        }
        if u {
            b.push(line);
        }
    }
    b.sort_by(|aa,bb| bb.len().cmp(&aa.len()));
    for l in b {
        println!("{}",l);
    }
}
