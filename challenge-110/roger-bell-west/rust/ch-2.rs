#! /bin/sh
//usr/bin/env rustc $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::io;
use std::io::prelude::*;

fn main() {
    let stdin = io::stdin();
    let mut a: Vec<Vec<String>>=vec![];
    for line in stdin.lock().lines() {
        let ll=line.unwrap();
        let r: Vec<&str>=ll.split(",").collect();
        for ci in 0..r.len() {
            while a.len() < ci+1 {
                a.push(vec![]);
            }
            a[ci].push(r[ci].to_string());
        }
    }
    for r in a {
        println!("{}",r.join(","));
    }
}
