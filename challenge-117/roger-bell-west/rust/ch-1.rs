#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::collections::HashSet;
use std::fs::File;
use std::io::{BufRead, BufReader};
use regex::Regex;

#[test]
fn test_ex1() {
    assert_eq!(mr("infile"),12);
}

fn mr(n: &str) -> i32 {
    let p=Regex::new(r"^([0-9]+)").unwrap();
    let mut f: HashSet<i32>=HashSet::new();
    let fh=File::open(n).unwrap();
    let reader=BufReader::new(fh);
    for line in reader.lines() {
        let l=line.unwrap();
        let m=p.captures(&l).unwrap();
        let a=m.get(1).unwrap().as_str().parse::<i32>().unwrap();
        f.insert(a);
    }
    let mut a: i32=1;
    loop {
        if !f.contains(&a) {
            return a;
        }
        a+=1;
    }
}
