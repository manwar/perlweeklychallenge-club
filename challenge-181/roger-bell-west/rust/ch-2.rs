#! /bin/sh
//usr/bin/env rustc $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

// use itertools::Itertools;
use std::collections::HashMap;
use std::fs::File;
use std::io::{prelude::*, BufReader};

fn main() {
    let mut t: HashMap::<String,i64> = HashMap::new();
    let file = File::open("temperature.txt").unwrap();
    let reader = BufReader::new(file);
    for lx in reader.lines() {
        let line = lx.unwrap();
        let l = line
            .split(&[',', ' '][..])
            .filter(|&x| x != "")
            .collect::<Vec<&str>>();
        t.insert(l[0].to_string(),l[1].parse::<i64>().unwrap());
    }

    let mut lt = 999;
    let mut kt = t.keys().map(|i| i.to_string()).collect::<Vec<String>>();
    kt.sort();
    for k in kt {
        if *t.get(&k).unwrap() > lt {
            println!("{}",k);
        }
        lt = *t.get(&k).unwrap();
    }
}
